class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, presence: true, length: { maximum: 100 }
  validates :phone, allow_nil: true, format: { with: PHONE_REGEX }
  validates :street, length: { maximum: 100 }
  validates :state, length: { maximum: 2 }
  validates :zip, length: { maximum: 20 }

  has_many :requests

  has_many :relationships, dependent: :destroy
  has_many :neighbors, through: :relationships, dependent: :destroy
  has_many :reverse_relationships, foreign_key: "neighbor_id", class_name: "Relationship", dependent: :destroy
  has_many :followers, through: :reverse_relationships, dependent: :destroy, source: :user

  def feed
    Request.from_users_followed_by(self)
  end

  def follow!(other_user)
    relationships.create!(neighbor_id: other_user.id)
  end
end
