class JobCallbackService

	def initialize(call_job, action)
		callback_params = {
			job: {
				id: call_job.external_job_id,
				status: action,
				timestamp: Date.new
			}
		}.to_json

		RestClient.post call_job.status_callback, callback_params, { content_type: :json }
	end

end