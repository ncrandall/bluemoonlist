class UsersController < ApplicationController
  def index
  	@users = User.all
  end

  def profile
  	@user = User.where(id: params[:id]).first
  	@requests = Request.where(user_id: params[:id])
  end
end
