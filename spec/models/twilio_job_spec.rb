require 'spec_helper'

describe TwilioJob do

	before do 
		@job = TwilioJob.new( phone: "555-555-5555", name: "John Doe" ) 
		@job.status = :active
	end

	subject { @job }

	it { should respond_to :phone }
	it { should respond_to :status }
	it { should respond_to :name }
	it { should respond_to :twilio_contacts }
	it { should be_valid }

	describe "with an invalid number" do
		before { @job.phone = "555-not-a-number" }
		it { should_not be_valid }
	end

	describe "with an invalid name" do
		before { @job.name = "" }
		it { should_not be_valid }
	end

	describe "with an empty status" do
		before { @job.status = nil }
		it { should_not be_valid }
	end

	describe "with an invalid status" do
		before { @job.status = :not_a_valid_status }
		it { should_not be_valid }
	end
end