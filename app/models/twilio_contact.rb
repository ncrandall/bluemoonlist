class TwilioContact < ActiveRecord::Base

	validates :name, presence: true, length: { maximum: 100 }
	validates :phone, presence: true, format: { with: PHONE_REGEX }
	validates :call_order, presence: true

	belongs_to :twilio_job
end
