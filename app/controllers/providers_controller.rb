class ProvidersController < ApplicationController
	def index
		@providers = Provider.all
	end

	def show
		@provider = Provider.where(id: params[:id]).first
	end
end
