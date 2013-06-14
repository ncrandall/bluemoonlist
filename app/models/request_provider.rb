class RequestProvider < ActiveRecord::Base

	#validates :request_id, presence: true
	validates :provider_id, presence: true
	validates :call_order, presence: true

	belongs_to :request
	belongs_to :provider
end
