def sign_in_user(user)
	visit new_user_session_path
	fill_in "user_email", with: user.email
	fill_in "user_password", with: user.password
	click_button "Log in"
end

def sign_out
	click_link "Sign out"
end