class Provider < ActiveRecord::Base

	validates :company_name, presence: true, length: { maximum: 100 }
	validates :first_name, length: { maximum: 100 }
	validates :last_name, length: { maximum: 100 }
	validates :phone, format: { with: PHONE_REGEX }
	validates :street, length: { maximum: 100 }
	validates :zip, length: { maximum: 20 }

	belongs_to :user

	has_many :request_providers, dependent: :destroy

	has_many :scores
	has_many :categories, through: :scores

	def full_name
    "#{first_name.capitalize} #{last_name.capitalize}"
  end
end
