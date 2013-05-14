require 'spec_helper'

describe "Category Pages" do

	before do 
		3.times do |num|
			Category.create(:name => "Category#{num}")
		end
	end

  let(:category) { Category.first }

	subject { page }

	describe "index page" do
		before { visit categories_path }

		it { should have_text("Category1") }
		it { should have_link(category.name) }
		it { should have_link("delete") }
		it { should have_link("edit") }
		it { should have_selector("h1", text: "Categories") }
	
		describe "delete links" do
			before do
				delete_all_categories_except(category.name)
				visit categories_path
			end

			it "should decrement the category count by 1" do
				expect { click_link("delete") }.to change(Category, :count).by(-1)
			end
		end
	end

	describe "show page" do
		before { visit category_path(category) }

		it { should have_link("delete") }
		it { should have_link("edit") }
		it { should have_selector("h1", text: category.name) }

		it "should decrement the category count by 1" do
			expect { click_link("delete") }.to change(Category, :count).by(-1)
		end
	end

	describe "edit page" do
		before { visit edit_category_path(category) }

		it { should have_selector("h1", text: "Edit Category") }
		it { should have_selector("input") }
		it { should have_button("Edit") }
		it { should have_link("Cancel") }

		describe "making an update" do
			before { fill_in "Name", :with => "new_name" }
			
			it "should update the name" do
				click_button "Edit"
				category.reload
				category.name.should eq("new_name")
			end
		end
	end

	describe "new page" do
		before { visit new_category_path }
		it { should have_selector("h1", text: "New Category") }

		describe "creating a new category" do
			before { fill_in "Name", with: "CategoryX" }

			it "should increment the number of categories by 1" do
				expect { click_button "Add" }.to change(Category, :count).by(1)
			end
		end
	end
end