require 'spec_helper'

describe Micropost do

	let(:user) { FactoryGirl.create(:user) }
	let(:micropost) { FactoryGirl.create(:micropost, user: user) }

	subject { micropost }

	it { should respond_to :description }
	it { should respond_to :user }
	it { should be_valid }

	describe "with a status too long" do
		before { micropost.description = "a" * 141 }
		it { should_not be_valid }
	end

	describe "without a description" do
		before { micropost.description = "" }
		it { should_not be_valid }
	end

	describe "without a user" do
		before { micropost.user = nil }
		it { should_not be_valid }
	end

end