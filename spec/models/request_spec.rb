require 'spec_helper'

describe Request do
	
	before do 
		@request = Request.new(description: "description of request")
		@request.status = :active
	end

	subject { @request }

	it { should respond_to :status }
	it { should respond_to :description }
	it { should be_valid }

	describe "status validations" do
		it "should be a valid status" do
			@request.status = :not_a_key
			@request.should_not be_valid
		end
	end

	describe "description validations" do
		it "most not exceed max length" do
			@request.description = "a" * 141
			@request.should_not be_valid
		end
	end
end