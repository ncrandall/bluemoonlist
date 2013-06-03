class Request < ActiveRecord::Base
	STATUS = { active: 0, paused: 1, cancelled: 2, done: 3 }
	
	# validates :status, inclusion: { in: STATUS }
	validates :description, length: { maximum: 140 }
	validates :status, presence: true
	validates :phone, presence: true, format: { with: PHONE_REGEX }
	validates :user_id, presence: true

	belongs_to :user
	# This relationship will be changed to REST call eventually (see class diagram)
	has_one :twilio_job, dependent: :destroy, autosave: true

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
end
