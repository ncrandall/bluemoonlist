class RequestHistoriesController < ApplicationController
	def index
		@histories = RequestHistory.where("request_id = ? AND created_at > ?", params[:request_id], Time.at(params[:after].to_i + 1))
	end
end
