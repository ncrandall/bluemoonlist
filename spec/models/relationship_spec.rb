require 'spec_helper'

describe Relationship do
	
	let(:user) { FactoryGirl.create(:user) }
	let(:neighbor) { FactoryGirl.create(:user) }

	before { @relationship = Relationship.create(user_id: user.id, neighbor_id: neighbor.id) }

	subject { @relationship }

	it { should respond_to :user_id }
	it { should respond_to :neighbor_id }
	it { should respond_to :user }
	it { should respond_to :neighbor }
	it { should be_valid }

	describe "without user_id" do
		before { @relationship.user_id = nil }
		it { should_not be_valid }
	end

	describe "without neighbor_id" do
		before { @relationship.neighbor_id  = nil }
		it { should_not be_valid }
	end
end