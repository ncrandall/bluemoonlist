class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :phone, allow_nil: true, format: { with: PHONE_REGEX }
  validates :street, length: { maximum: 100 }
  validates :state, length: { maximum: 2 }
  validates :zip, length: { maximum: 20 }

  has_many :requests
end
