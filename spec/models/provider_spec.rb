require 'spec_helper'

describe Provider do

	let(:provider) { FactoryGirl.create(:provider) }

	subject { provider }

  it { should respond_to :company_name }
  it { should respond_to :first_name }
  it { should respond_to :last_name }
  it { should respond_to :phone }
  it { should respond_to :street }
  it { should respond_to :city }
  it { should respond_to :state }
  it { should respond_to :zip }

  it { should respond_to :user}
  it { should respond_to :request_providers }
  it { should respond_to :scores }
  it { should respond_to :categories }
  
  it { should be_valid }

  describe "with an invalid company_name" do
    before { provider.company_name = "" }
    it { should_not be_valid }
  end

  describe "with an invalid first_name" do
    before { provider.first_name = "a" * 101 }
    it { should_not be_valid }
  end

  describe "with an invalid last_name" do
    before { provider.last_name = "a" * 101 }
    it { should_not be_valid }
  end

  describe "with an invalid phone" do
    before { provider.phone = "800-not-a-number" }
    it { should_not be_valid }
  end

  describe "with an invalid street" do
    before { provider.street = "a" * 101 }
    it { should_not be_valid }
  end

  describe "zip validations" do
    before { provider.zip = "a" * 21 }
    it { should_not be_valid }
  end
end