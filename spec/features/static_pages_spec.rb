require 'spec_helper'

describe "Static Pages" do

	let(:user) { FactoryGirl.create(:user) }
	let(:new_user) { FactoryGirl.build(:user) }

	subject { page }

	before { sign_in_user(user) }

	describe "Home Page" do
		before do 
			sign_out
			visit root_path
		end

		it { should have_selector("input", visible: "Sign up") }
		it { should have_selector("input", visible: "Log in") }
		it { should have_text "Find a contractor"}

		describe "login in" do
			before do 
				find(:css, "form:first #user_email").set(user.email)
				find(:css, "form:first #user_password").set(user.password)
				click_button "Log in"
			end

			it { should have_selector "h4", text: "What are you looking for?" }
		end

		describe "sign up" do
			before do
				find(:css, "form:last #user_email").set(new_user.email)
				find(:css, "form:last #user_password").set(new_user.password)
				find(:css, "form:last #user_password_confirmation").set(new_user.password_confirmation)
				find(:css, "form:last #user_first_name").set(new_user.first_name)
				find(:css, "form:last #user_last_name").set(new_user.last_name)
			end

			it "should increment number of users" do
				expect { click_button "Sign up" }.to change(User,:count).by(1)
			end
		end
	end

	describe "Feed Page" do
		before { visit feed_path }

		it { should have_selector "h4", text: "What are you looking for?" }

		describe "when not logged in" do
			before do 
				sign_out
				visit feed_path
			end

			it { should have_text "Sign in" }
		end
	end
end