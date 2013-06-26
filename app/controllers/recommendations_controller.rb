class RecommendationsController < ApplicationController

	def create
		@recommendation = current_user.recommendations.build(recommendation_params)

		if @recommendation.save
			@recommendation.save_history
			flash[:success] = "Successfully created recommendation"
		else
			flash[:error] = "Couldn't save recommendation"
		end

		redirect_to request_path(params[:recommendation][:request_id])
	end

	def destroy
		@recommendation = Recommendation.where(id: params[:id]).first

		if @recommendation.destroy
			flash[:success] = "Successfully removed recommendation"
		else
			flash[:error] = "Couldn't remove recommendation"
		end

		redirect
	end

	private

	def recommendation_params
		params.require(:recommendation).permit(:user_id, :provider_id, :request_id)
	end

end
