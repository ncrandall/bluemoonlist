class Category < ActiveRecord::Base
	validates :name, presence: true, length: { maximum: 50 }, uniqueness: true

	has_many :scores
	has_many :providers, through: :scores
	has_many :requests
end
