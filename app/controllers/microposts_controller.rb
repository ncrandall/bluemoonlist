class MicropostsController < ApplicationController

	def index
		@microposts = Micropost.all
		@micropost = Micropost.new
	end

	def show
		@micropost = Micropost.where(id: params[:id]).first
	end

	def new
		@micropost = Micropost.new
	end

	def create
		@micropost = current_user.microposts.build(micropost_params)

		if @micropost.save
			flash[:success] = "Created Status Update"
			redirect_to microposts_path
		else
			flash[:error] = "Error Creating Status Update"
			render 'new'
		end
	end

	def destroy
		@micropost = current_user.microposts.where(id: params[:id]).first

		if @micropost.destroy
			flash[:success] = "Removed Status Update"
		else
			flash[:error] = "Couldn't Remove Status Update"
		end
		redirect_to microposts_url
	end

	private

	def micropost_params
		params.require(:micropost).permit(:description)
	end
end
