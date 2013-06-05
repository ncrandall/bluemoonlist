require 'spec_helper'

describe Request do
	
	let(:user) { FactoryGirl.create(:user) }
	let(:category) { FactoryGirl.create(:category) }
	let(:request) { FactoryGirl.build(:request, user: user, status: 0, category: category) }

	subject { request }

	it { should respond_to :status }
	it { should respond_to :description }
	it { should respond_to :phone }
	it { should respond_to :user }
	it { should respond_to :street }
	it { should respond_to :city }
	it { should respond_to :state }
	it { should respond_to :zip }
	it { should respond_to :twilio_job }
	it { should respond_to :category_id }
	it { should be_valid }

	# validations

	describe "without a user id" do
		before { request.user_id = nil }
		it { should_not be_valid }
	end

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

	describe "with an invalid street" do
		before { request.street = "a" * 101 }
		it { should_not be_valid }
	end

	describe "with an invalid city" do
		before { request.city = "a" * 101 }
		it { should_not be_valid }
	end

	describe "with an invalid state" do
		before { request.state = "CAA" }
		it { should_not be_valid }
	end

	describe "with an invalid zip" do
		before { request.zip = "a" * 21 }
		it { should_not be_valid }
	end

	describe "without a category" do
		before { request.category_id = nil }
		it { should_not be_valid }
	end

	describe "when request is destroyed" do
		before {	FactoryGirl.create(:twilio_job, request: request) }

		it "should delete dependent TwilioJobs" do
			expect { request.destroy }.to change(TwilioJob, :count).by(-1)
		end
	end

	# methods
	describe "with another non-closed request" do
		before do 
			new_request = FactoryGirl.create(:request, user: user, status: 0, category: category)
			new_request.save
		end

		it { should_not be_valid }
	end
end