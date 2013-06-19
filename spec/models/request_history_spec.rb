require 'spec_helper'

describe RequestHistory do

	before { @request = RequestHistory.new(status: "paused", request_id: 0, request_provider_id: 0) }

	subject { @request }

	it { should respond_to :status }
	it { should respond_to :request_id }
	it { should respond_to :request_provider_id }
	it { should respond_to :request }
	it { should be_valid }

	describe "without a request" do
		before { @request.request_id = nil }
		it { should_not be_valid }
	end

end
