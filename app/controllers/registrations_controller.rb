class RegistrationsController < Devise::RegistrationsController
	def sign_up_params
		params.require(:user).permit(:email, :password, :password_confirmation, 
			:first_name, :last_name)
	end

	def account_update_params
		params.require(:user).permit(:email, :password, :password_confirmation,
			:first_name, :last_name, :street, :city, :state, :zip, :current_password)
	end
end
