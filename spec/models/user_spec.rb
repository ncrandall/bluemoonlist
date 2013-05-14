require 'spec_helper'

describe User do

	before { @user = User.new(
		email: "example@example.com", 
		password: "foobar", 
		password_confirmation: "foobar",
		phone: "555-555-5555",
		street: "123 Fake St",
		city: "Springfield",
		state: "OR",
		zip: "97475")
	}

	subject { @user }

	it { should respond_to :street }
	it { should respond_to :city }
	it { should respond_to :state }
	it { should respond_to :zip }

	describe "phone validations" do
		it "should be a valid phone number" do
			@user.phone = "555-55-5555"
			@user.should_not be_valid
		end
	end

	describe "street validations" do
		it "should not exceed max length" do
			@user.street = "a" * 101
			@user.should_not be_valid
		end
	end

	describe "state validations" do
		it "should only be two chars" do
			@user.state = "CAA"
			@user.should_not be_valid
		end
	end

	describe "zip validations" do
    it "shouldn't exceed maximum length" do
      @user.zip = "a" * 21
      @user.should_not be_valid
    end
  end
end