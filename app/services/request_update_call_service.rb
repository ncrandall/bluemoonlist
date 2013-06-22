class RequestUpdateCallService

	def initialize(request, status)
		# TODO: Change the id to the job id once we store the twilio_job id locally
		url = "#{ENV['CALL_SERVICE_URL']}/twilio_jobs/#{request.id}"

		params = {
			twilio_job: {
				external_job_id: request.id,
				status: status.to_s
			}
		}.to_json

		RestClient.put url, params, { content_type: :json }
	end

end