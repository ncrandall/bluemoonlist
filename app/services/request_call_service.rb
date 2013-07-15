class RequestCallService

	def initialize(request)
		call_params = { 
			call_job: {
				name: request.user.full_name,
				phone: request.phone,
				status: 0,
				contact_method: :call,
				status_callback: "#{ENV['BLUEMOONLIST_URL']}requests/callback",
				external_job_id: request.id,
				providers: []
			}
		}

		request.request_providers.each do |p|
			call_params[:call_job][:providers].push(
				{ provider:	{ 
						name: p.provider.full_name, 
						phone: p.provider.phone, 
						category: request.category.name,
						call_order: p.call_order,
						external_contact_id: p.id
					} 
				})
		end

		body = call_params.to_json

		url = "#{ENV['CALL_SERVICE_URL']}call_jobs"

		response = RestClient.post url, body, { content_type: :json }
	end

end