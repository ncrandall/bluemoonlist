class Provider < ActiveRecord::Base

	validates :name, presence: true, length: { maximum: 100 }
	validates :phone, format: { with: PHONE_REGEX }
	validates :street, length: { maximum: 100 }
	validates :zip, length: { maximum: 20 }

	has_many :scores
	has_many :categories, through: :scores
end
