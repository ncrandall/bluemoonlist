class RequestHistory < ActiveRecord::Base
	default_scope -> { order("created_at DESC") }
	validates :request_id, presence: true
	belongs_to :request
end
