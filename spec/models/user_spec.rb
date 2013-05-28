require 'spec_helper'

describe User do

	let(:user) { FactoryGirl.create(:user) }

	subject { user }

	it { should respond_to :name }
	it { should respond_to :street }
	it { should respond_to :city }
	it { should respond_to :state }
	it { should respond_to :zip }
	it { should respond_to :phone }
	it { should respond_to :requests }
	it { should respond_to :neighbors }
	it { should respond_to :followers }
	it { should be_valid }

	describe "phone validations" do
		before { user.phone = "555-55-5555"}
		it { should_not be_valid }
	end

	describe "with an invalid name" do
		before { user.name = "a" * 101 }
		it { should_not be_valid }
	end

	describe "with an empty name" do
		before { user.name = "" * 101 }
		it { should_not be_valid }
	end

	describe "with an invalid street" do
		before { user.street = "a" * 101 }
		it { should_not be_valid }
	end

	describe "with an invalid state" do
		before { user.state = "CAA" }
		it { should_not be_valid }
	end

	describe "with an invalid zip" do
    before { user.zip = "a" * 21 }
    it { should_not be_valid }
  end
end