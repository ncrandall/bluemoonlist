class StaticController < ApplicationController
	before_filter :authenticate_user!, except: [:home] 

	def home
		if !current_user.nil?
			redirect_to feed_path
		end
  end

  def about
  end

  def feed
    @request = Request.new
    @categories = Category.all
    @open_request = current_user.requests.where(status: [0, 1]).any?

  	@filter ||= params[:filter]
  	
  	if @filter == 'self'
  		@requests = current_user.requests
  	else
  		@requests = current_user.feed
  	end
  end
end
