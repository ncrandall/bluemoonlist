class TwilioContact < ActiveRecord::Base

	validates :name, presence: true, length: { maximum: 100 }
	validates :phone, presence: true, format: { with: PHONE_REGEX }
	validates :category, presence: true
	validates :call_order, presence: true
	validates :external_contact_id, presence: true

	belongs_to :twilio_job

	def make_callback(action)
    ContactCallbackService.new(self, action)
  end
end
