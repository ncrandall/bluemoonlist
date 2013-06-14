require 'spec_helper'
require 'pp'

describe 'Request Pages' do

	let(:user) { FactoryGirl.create(:user) }
	let(:category) { FactoryGirl.create(:category) }
	let(:other_user) { FactoryGirl.create(:user) }
	let(:request) { FactoryGirl.build(:request, user: user, status: :working, category: category) }

	before { sign_in_user(user) }

	subject { page }

	describe 'index page' do
		before do 
			FactoryGirl.create(:category)
			visit requests_path
		end

		it { should have_selector("h4", text: "What are you looking for?") }

		describe "adding new request" do

			it "should increment request count" do
				fill_in "request_phone", with: "555-555-5555"

				expect do
					click_button 'Request Call'
				end.to change(Request, :count).by(1)
			end
		end

		describe "user should only see his requests" do
			before do
				2.times { FactoryGirl.create(:request, user: user, status: :working, category: category) }
				3.times { FactoryGirl.create(:request, user: other_user, status: :working, phone: '111-111-1111', category: category) }
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
			before do 
				request.save
				visit request_path(request.id)
			end
			it { should have_text request.description }
		end
	end
end