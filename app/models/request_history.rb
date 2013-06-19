class RequestHistory < ActiveRecord::Base

	validates :request_id, presence: true
	belongs_to :request
end
