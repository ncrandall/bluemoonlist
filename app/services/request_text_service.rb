class RequestTextService
	
	def initialize(request)
		request_provider = RequestProvider.where(id: request.last_contacted_provider_id).first

		params = {
			twilio_job: {
				phone: request_provider.provider.phone,
				contact_method: 1,
				status_callback: "#{ENV['BLUEMOONLIST_URL']}requests/callback",
				status: 0,
				name: request_provider.provider.full_name,
				external_job_id: request.id,
				body: "#{request.description}\n\n#{request.street}\n#{request.city} #{request.state}, 
				#{request.zip}\n\nphone: #{request.phone}"
			}
		}
		url = "#{ENV['CALL_SERVICE_URL']}twilio_jobs"

		RestClient.post url, params, { content_type: :json }  
	end
end