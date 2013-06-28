class RelationshipsController < ApplicationController

	def create
		@user = User.where(id: params[:relationship][:neighbor_id]).first
		current_user.follow!(@user)

		respond_to do |format|
			format.html { redirect_to profile_path(params[:neighbor_id]) }
			format.js
		end
	end

	def destroy
		@user = User.where(id: params[:relationship][:neighbor_id]).first
		current_user.unfollow!(@user)

		respond_to do |format|
			format.html { redirect_to profile_path(params[:relationship][:user_id]) }
			format.js
		end
	end
end
