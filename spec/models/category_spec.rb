require 'spec_helper'

describe Category do

	before { @category = Category.new(:name => "plumber") }

	subject { @category }

  it { should respond_to :name }
  it { should_not respond_to :not_an_attr }
  it { should be_valid }

  describe "name shouldn't be empty" do
  	before { @category.name = "" }
  	it { should_not be_valid }
  end

  describe "name should not exceed max length" do
  	before { @category.name = "a" * 51 }
  	it { should_not be_valid }
  end

  describe "name should be unique" do
  	before do 
  		@dup = Category.create(:name => @category.name) 
  	end
  	
  	it { should_not be_valid }
  end

end