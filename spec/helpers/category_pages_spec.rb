require 'spec_helper'

def delete_all_categories_except(name)
	categories = Category.all
	categories.each do |cat|
		if cat.name != name
			cat.destroy
		end
	end
end