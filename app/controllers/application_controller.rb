class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_permitted_params, if: :devise_controller?

  protected

  def configure_permitted_params
  	devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:phone, :street, :city, :state, :zip, :email, :password, :password_confirmation) }
  	devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:phone, :street, :city, :state, :zip) }
  end
end
