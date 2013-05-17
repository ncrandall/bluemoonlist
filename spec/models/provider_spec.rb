require 'spec_helper'

describe Provider do

	let(:provider) { FactoryGirl.create(:provider) }

	subject { provider }

  it { should respond_to :contact }
  it { should respond_to :phone }
  it { should respond_to :street }
  it { should respond_to :city }
  it { should respond_to :state }
  it { should respond_to :zip }
  it { should_not respond_to :not_an_attr }

  it { should respond_to :scores }
  it { should respond_to :categories }
  
  it { should be_valid }

  describe "name validations" do

    it "shouldn't allow empty name" do
      provider.name = ""
      provider.should_not be_valid
    end

    it "shouldn't exceed max length" do
      provider.name = "a" * 101
      provider.should_not be_valid
    end
  end

  describe "phone validations" do
  	it "should be a valid phone number" do
      provider.phone = "800-not-a-number"
      provider.should_not be_valid
    end
  end

  describe "street validations" do
  	it "shouldn't exceed max length" do
      provider.street = "a" * 101
      provider.should_not be_valid
    end
  end

  describe "zip validations" do
    it "shouldn't exceed maximum length" do
      provider.zip = "a" * 21
      provider.should_not be_valid
    end
  end

end