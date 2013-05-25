require 'spec_helper'

describe 'Request Pages' do

	let(:user) { FactoryGirl.create(:user) }
	let(:other_user) { FactoryGirl.create(:user) }
	let(:request) { FactoryGirl.create(:request, user: user, status: 0) }

	before { sign_in_user(user) }

	subject { page }

	describe 'index page' do
		before { visit requests_path }
		it { should have_selector("h1", text: "Requests") }

		it "should increment request count" do
			fill_in "Phone", with: "555-555-5555"
			fill_in "Description", with: "Find an electrician"
			expect { click_button 'Request Call' }.to change(Request, :count).by(1)
		end

		describe "user should only see his requests" do
			before do
				2.times { FactoryGirl.create(:request, user: user, status: 0) }
				3.times { FactoryGirl.create(:request, user: other_user, status: 0, phone: '111-111-1111') }
				visit requests_path
			end
			it { should_not have_text "111-111-1111" }
		end

		describe "when not signed in" do
			before do 
				sign_out
				visit requests_path
			end
			it { should have_text "Sign up"}
		end
	end

#	describe 'edit page' do
#		before { visit edit_request_path(request.id) }
#		it { should have_text request.description }
#	end

	describe 'show page' do
		describe "when logged in" do
			before { visit request_path(request.id) }
			it { should have_text request.description }
		end
	end
end