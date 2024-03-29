require 'spec_helper'

describe CallJob do

	let(:call_job) { FactoryGirl.build(:call_job, external_job_id: 0, status: 0) }

	subject { call_job }

	it { should respond_to :phone }
	it { should respond_to :status }
	it { should respond_to :name }
	it { should respond_to :twilio_contacts }
	it { should respond_to :external_job_id }
	it { should respond_to :call_sid }
	it { should respond_to :status_callback }
	it { should respond_to :contact_method }
	it { should respond_to :body }
	it { should be_valid }

	describe "with an invalid number" do
		before { call_job.phone = "555-not-a-number" }
		it { should_not be_valid }
	end

	describe "with an invalid name" do
		before { call_job.name = "" }
		it { should_not be_valid }
	end

	describe "with an invalid status" do
		before { call_job.status = :not_a_valid_status }
		it { should be_valid }
	end

	describe "with an invalid call_sid" do
		before { call_job.call_sid = "a" * 37 }
		it { should_not be_valid }
	end

	describe "body should be limited" do
		before { call_job.body = "a" * 201 }
		it { should_not be_valid }
	end
end