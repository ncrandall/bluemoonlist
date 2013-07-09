class Request < ActiveRecord::Base
	# Always return requests in descending order from DB
	default_scope -> { order('created_at DESC') }

	STATUS = { active: 0, paused: 1, cancelled: 2, working: 3, invoicing: 4, done: 5 }
	
	# validates :status, inclusion: { in: STATUS }
	validates :description, length: { maximum: 140 }
	validates :status, presence: true
	validates :phone, presence: true, format: { with: PHONE_REGEX }
	validates :user_id, presence: true
	validates :street, length: { maximum: 100 }
	validates :city, length: { maximum: 100 }
	validates :state, length: { maximum: 2 }
	validates :zip, length: { maximum: 20 }
	validates :category_id, presence: true

	validate :user_has_open_request, on: :create

	belongs_to :user
	belongs_to :category

	has_many :request_providers, dependent: :destroy, autosave: true
	has_many :request_histories, dependent: :destroy
	has_one :rating

	def status
		STATUS.key(read_attribute(:status))
	end

	def status=(s)
		write_attribute(:status, STATUS[s])
	end

	before_validation do
		if self.id.nil? && self.status.nil?
			self.status = :active
		end
	end

	def self.from_users_followed_by(user)
		select_sql = "SELECT neighbor_id FROM relationships WHERE user_id = :user_id"
		where("user_id IN (#{select_sql}) OR user_id = :user_id", user_id: user.id)
	end

	def user_has_open_request
		if Request.open_request(user_id) && status.in?([:active,:paused])
			errors.add(:user_id, "has an open request")
		end
	end

	def self.open_request(id)
		Request.where(status: [0, 1], user_id: id).first
	end

	def build_provider_list
		RequestProviderListService.new self
		self
	end

	def send_text
		RequestTextService.new self
	end

	def make_calls
		RequestCallService.new self
	end

	def update_call_status(s)
		if s != self.status && s.in?([:active, :paused, :cancelled, :done])
			RequestUpdateCallService.delay.new self, s
		end
	end

	def process_callback(params)
		request_history = RequestHistory.new(
			request: Request.find(params[:id]), 
			status: params[:status],
			request_provider_id: params[:contact_id]
		)

		process_request_from_callback params
		request_history.save
	end

	def process_request_from_callback(params)
		request = Request.where(id: params[:id]).first
		
		request.status = params[:status].to_sym unless !params[:status].to_sym.in?(STATUS.keys)
		request.last_contacted_provider_id = params[:contact_id]

		request.save unless !request.changed?
	end

	def last_contacted_provider
		self.request_providers.where(id: last_contacted_provider_id).first.provider
	end
end
