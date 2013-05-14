require 'spec_helper'

describe Category do

	before { @category = Category.new(name: "plumber") }

	subject { @category }

  it { should respond_to :name }
  it { should_not respond_to :not_an_attr }
  it { should be_valid }

  describe "name validations" do
    it "can't be empty" do
    	@category.name = ""
    	@category.should_not be_valid
    end

    it "should not exceed max length" do
    	@category.name = "a" * 51
    	@category.should_not be_valid
    end

    it "should be unique" do
    	@dup = Category.create(name: @category.name) 
    	@category.should_not be_valid
    end
  end
end