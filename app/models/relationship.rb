class Relationship < ActiveRecord::Base

	belongs_to :user
	belongs_to :neighbor, class_name: "User"

	validates :user_id, presence: true
	validates :neighbor_id, presence: true


end
