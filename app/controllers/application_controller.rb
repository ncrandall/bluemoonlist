class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  #before_filter :configure_permitted_params, if: :devise_controller?

  def after_sign_in_path_for(resource)
    feed_path
  end
end
