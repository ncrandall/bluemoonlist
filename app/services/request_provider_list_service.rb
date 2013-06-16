class RequestProviderListService

	# TODO: implement recommendation engine for service providers
	def initialize(request)
		providers = Provider.where(id: Score.where(category_id: request.category_id)).limit(3)

    cnt = 0
    providers.each do |p|
      request.request_providers.build(provider: p, call_order: cnt)
      cnt += 1
    end 
	end
end