class ContactCallbackService

	def initialize(contact, action)
		callback_params = {
			external_contact_id: contact.external_contact_id,
			action: action,
			timestamp: Date.new
		}.to_json

		RestClient.post contact.twilio_job.status_callback, callback_params, { content_type: :json }
	end

end