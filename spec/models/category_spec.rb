require 'spec_helper'

describe Category do

	let(:category) { FactoryGirl.create(:category) }

	subject { category }

  it { should respond_to :name }
  it { should_not respond_to :not_an_attr }

  it { should respond_to :scores }
  it { should respond_to :providers }
  it { should be_valid }

  describe "name validations" do
    it "can't be empty" do
    	category.name = ""
    	category.should_not be_valid
    end

    it "should not exceed max length" do
    	category.name = "a" * 51
    	category.should_not be_valid
    end

    it "should be unique" do
    	dup = Category.new(name: category.name) 
    	dup.should_not be_valid
    end
  end
end