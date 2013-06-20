class RequestTextService
	
	def initialize(request)
		params = {
			phone: request.phone,
			contact_method: :text
		}
		url = "#{ENV['CALL_SERVICE_URL']}/twilio_job"

		RestClient.post url, params, { content_type: :json }  
	end
end