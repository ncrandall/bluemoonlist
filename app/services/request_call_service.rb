class RequestCallService

	def initialize(request)
		call_params = {
			name: request.user.full_name,
			phone: request.phone,
			status: 0,
			status_callback: 'http://morning-shelf-8847.herokuapp.com/requests/callback',
			providers: []
		}

		request.request_providers.each do |p|
			call_params[:providers].push(
				{ provider:	{ name: p.provider.full_name, phone: p.provider.phone } })
		end

		Rails.logger.info(call_params.to_json)

		url = "http://morning-shelf-8847.herokuapp.com/twilio_jobs"
		headers = { content_type: "application/json" }

		response = RestClient.post url, call_params, headers
	end

end