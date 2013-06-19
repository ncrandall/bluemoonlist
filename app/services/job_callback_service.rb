class JobCallbackService

	def initialize(twilio_job, action)
		callback_params = {
			job: {
				id: twilio_job.external_job_id,
				status: action,
				timestamp: Date.new
			}
		}.to_json

		RestClient.post twilio_job.status_callback, callback_params, { content_type: :json }
	end

end