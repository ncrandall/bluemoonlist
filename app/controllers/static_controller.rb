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
    @request = Request.open_request(current_user.id) || Request.new
    @categories = Category.all

  	@feed = current_user.feed
  end
end
