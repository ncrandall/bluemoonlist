require 'spec_helper'

describe "Static Pages" do

	subject { page }

	describe "Home Page" do
		before { visit root_path }

		it { should have_selector("input", visible: "Sign up") }
		it { should have_selector("input", visible: "Log in") }
	end
end