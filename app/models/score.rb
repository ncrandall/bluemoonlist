class Score < ActiveRecord::Base

	belongs_to :category
	belongs_to :provider
	
end
