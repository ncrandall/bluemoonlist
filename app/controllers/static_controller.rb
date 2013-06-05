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
    @request = Request.new.get_open_request_for_user(current_user.id)
    
    redirect_to request_path(@request) unless @request.nil?

    @request = Request.new

  	@filter ||= params[:filter]
  	
  	if @filter == 'self'
  		@requests = current_user.requests
  	else
  		@requests = current_user.feed
  	end
  end
end
