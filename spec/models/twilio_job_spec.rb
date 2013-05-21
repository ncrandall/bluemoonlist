require 'spec_helper'

describe TwilioJob do


	let(:twilio_job) { FactoryGirl.build(:twilio_job, status: 0) }

	subject { twilio_job }

	it { should respond_to :phone }
	it { should respond_to :status }
	it { should respond_to :name }
	it { should respond_to :twilio_contacts }
	it { should respond_to :request}
	it { should be_valid }

	describe "with an invalid number" do
		before { twilio_job.phone = "555-not-a-number" }
		it { should_not be_valid }
	end

	describe "with an invalid name" do
		before { twilio_job.name = "" }
		it { should_not be_valid }
	end

	describe "with an invalid status" do
		before { twilio_job.status = :not_a_valid_status }
		it { should be_valid }
	end
end