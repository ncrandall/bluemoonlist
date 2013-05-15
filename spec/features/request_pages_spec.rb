require 'spec_helper'

describe 'Request Pages' do

	let(:request) { Request.create(phone: '555-555-5555', description: "looking for a plumber") }

	subject { page }

	describe 'index page' do
		before { visit requests_path }
		it { should have_selector("h1", text: "Requests") }

		it "should increment request count" do
			fill_in "Phone", with: "555-555-5555"
			fill_in "Description", with: "Find an electrician"
			expect { click_button 'Request Call' }.to change(Request, :count).by(1)
		end
	end

#	describe 'edit page' do
#		before { visit edit_request_path(request.id) }
#		it { should have_text request.description }
#	end

	describe 'show page' do
		before { visit request_path(request.id) } 
		it { should have_text request.description }
	end
end