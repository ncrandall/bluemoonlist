require 'spec_helper'

describe Request do
	
	let(:user) { FactoryGirl.create(:user) }
	let(:request) { FactoryGirl.build(:request, user: user, status: 0) }

	subject { request }

	it { should respond_to :status }
	it { should respond_to :description }
	it { should respond_to :phone }
	it { should respond_to :user }
	it { should respond_to :twilio_job }
	it { should be_valid }

	# validations

	describe "when status is initially not valid" do
		before { request.status = :not_a_key }
		it { should be_valid }
	end

	describe "with invalid description" do
		before { request.description = "a" * 141 }
		it { should_not be_valid }
	end

	describe "with an invalid phone number" do
		before { request.phone = '88-8888' }
		it { should_not be_valid }
	end

	describe "when a request is saved" do
		it "should create a twilio job and contacts" do
			expect { request.save }.to change(TwilioJob, :count).by(1)
		end
	end
end