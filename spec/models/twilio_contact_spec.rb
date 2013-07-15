require 'spec_helper'

describe TwilioContact do

  let(:twilio_contact) { FactoryGirl.create(:twilio_contact, external_contact_id: 0) } 

	subject { twilio_contact }

	it { should respond_to :phone }
	it { should respond_to :call_order }
	it { should respond_to :name }
	it { should respond_to :category }
	it { should respond_to :call_job_id }
	it { should respond_to :contacted }
	it { should respond_to :accepted }
	it { should respond_to :external_contact_id }
	it { should be_valid }

	describe "with an invalid number" do
		before { twilio_contact.phone = "555-not-a-number" }
		it { should_not be_valid }
	end

	describe "with an invalid name" do
		before { twilio_contact.name = "" }
		it { should_not be_valid }
	end

	describe "with an empty order" do
		before { twilio_contact.call_order = nil }
		it { should_not be_valid }
	end

	describe "with an emtpy category" do
		before { twilio_contact.category = "" }
		it { should_not be_valid }
	end
end