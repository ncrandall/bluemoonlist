require 'spec_helper'

describe Recommendation do
	let(:user) { FactoryGirl.create(:user) }
	let(:provider) { FactoryGirl.create(:provider) }
	let(:category) { FactoryGirl.create(:category) }
	let(:request) { FactoryGirl.create(:request, user: user, category: category)}
	let(:recommendation) { FactoryGirl.create(:recommendation, user: user, provider: provider, request: request)}

	subject { recommendation }

	it { should respond_to :user }
	it { should respond_to :request }
	it { should respond_to :provider }
	it { should be_valid }

	describe "without a user" do
		before { recommendation.user = nil }
		it { should_not be_valid }
	end

	describe "without a request" do
		before { recommendation.request = nil }
		it { should_not be_valid }
	end

	describe "without a provider" do
		before { recommendation.provider = nil }
		it { should_not be_valid }
	end
end