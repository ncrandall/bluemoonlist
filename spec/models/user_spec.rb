require 'spec_helper'

describe User do

	let(:user) { FactoryGirl.create(:user) }
	let(:other_user) { FactoryGirl.create(:user) }

	subject { user }
	it { should respond_to :uid }
	it { should respond_to :provider }

	it { should respond_to :first_name }
	it { should respond_to :last_name }
	it { should respond_to :street }
	it { should respond_to :city }
	it { should respond_to :state }
	it { should respond_to :zip }
	it { should respond_to :phone }
	it { should respond_to :requests }
	it { should respond_to :neighbors }
	it { should respond_to :followers }

	it { should respond_to :feed }
	it { should respond_to :neighbors }
	it { should respond_to :relationships }
	it { should respond_to :followers }
	it { should respond_to :reverse_relationships }
	it { should respond_to :follow! }

	it { should be_valid }

	describe "phone validations" do
		before { user.phone = "555-55-5555"}
		it { should_not be_valid }
	end

	describe "with an empty first_name" do
		before { user.first_name = "a" * 101 }
		it { should_not be_valid }
	end

	describe "with an empty last_name" do
		before { user.last_name = "a" * 101 }
		it { should_not be_valid }
	end

	describe "with an invalid street" do
		before { user.street = "a" * 101 }
		it { should_not be_valid }
	end

	describe "with an invalid city" do
		before { user.city = "a" * 101 }
		it { should_not be_valid }
	end

	describe "with an invalid state" do
		before { user.state = "CAA" }
		it { should_not be_valid }
	end

	describe "with an invalid zip" do
    before { user.zip = "a" * 21 }
    it { should_not be_valid }
  end

  # methods

  describe "neighbors" do
  	before do 
  		user.follow!(other_user)
  	end

  	its(:neighbors) { should include(other_user) }
  end

  describe "followers" do
  	before do
  		other_user.follow!(user)
  	end

  	its(:followers) { should include(other_user) }
  end

  describe "user feed" do
  	before do 
  		3.times { FactoryGirl.create(
  			:request, 
  			user: other_user, 
  			category: FactoryGirl.create(:category),
  			status: :working)
  		}
  		user.follow!(other_user)
  	end
  	its(:feed) do
  		other_user.requests.each do |req|
  	 		should include(req)
  		end
  	end
  end
end