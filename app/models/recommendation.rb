class Recommendation < ActiveRecord::Base
	validates :user_id, presence: true
	validates :provider_id, presence: true
	validates :request_id, presence: true

	belongs_to :request
	belongs_to :user
	belongs_to :provider

	def save_history
		request_history = RequestHistory.create(request_id: request_id, status: "#{user.full_name} Recommended #{provider.company_name}")
	end
end
