class ContactCallbackService

	def initialize(contact, action)
		callback_params = {
			job: {
				id: contact.twilio_job.external_job_id,
				contact_id: contact.external_contact_id,
				status: action,
				timestamp: Date.new
			}
		}.to_json

		RestClient.post contact.twilio_job.status_callback, callback_params, { content_type: :json }
	end

end