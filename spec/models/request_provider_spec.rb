require 'spec_helper'

describe RequestProvider do

	let(:user) { FactoryGirl.create(:user) }
	let(:category) { FactoryGirl.create(:category) }
	let(:request) { FactoryGirl.create(:request, user: user, category: category) }
	let(:provider) { FactoryGirl.create(:provider) }
	let(:request_provider) { FactoryGirl.create(:request_provider, provider: provider, request: request) }

	subject { request_provider }

	it { should respond_to :request }
	it { should respond_to :provider }
	it { should respond_to :call_order }
	it { should respond_to :contacted }
	it { should respond_to :accepted }

	describe "when provider is not present" do
		before { request_provider.provider_id = nil }
		it { should_not be_valid }
	end

	describe "when call_order is not present" do
		before { request_provider.call_order = nil }
		it { should_not be_valid }
	end
end