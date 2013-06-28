class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]

  validates :first_name, presence: true, length: { maximum: 100 }
  validates :last_name, presence: true, length: { maximum: 100 }
  validates :phone, allow_nil: true, format: { with: PHONE_REGEX }
  validates :street, length: { maximum: 100 }
  validates :state, length: { maximum: 2 }
  validates :city, length: { maximum: 100 }
  validates :zip, length: { maximum: 20 }

  has_many :requests, dependent: :destroy
  has_many :microposts, dependent: :destroy
  has_many :recommendations, dependent: :destroy

  has_many :relationships, dependent: :destroy
  has_many :neighbors, through: :relationships, dependent: :destroy
  has_many :reverse_relationships, foreign_key: "neighbor_id", class_name: "Relationship", dependent: :destroy
  has_many :followers, through: :reverse_relationships, dependent: :destroy, source: :user

  def feed
    requests = requests_feed
    microposts = microposts_feed
    requests.concat(microposts).sort_by(&:created_at).reverse
  end

  def requests_feed
    Request.from_users_followed_by(self).to_a
  end

  def microposts_feed
    Micropost.from_users_followed_by(self).to_a
  end

  def self.find_for_facebook_oauth(auth, signed_in_resrouce=nil)
    #user = User.where(provider: auth.provider, uid: auth.uid).first
    user = User.where(email: auth.info.email).first
    unless user
      user = User.create(
        image_url: auth.info.image,
        first_name: auth.extra.raw_info.first_name,
        last_name: auth.extra.raw_info.last_name,
        provider: auth.provider,
        uid: auth.uid,
        email: auth.info.email,
        password: Devise.friendly_token[0,20]
        )
    end
    user
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def full_name
    "#{first_name.capitalize} #{last_name.capitalize}"
  end

  def following?(other_user)
    relationships.where(neighbor_id: other_user.id).first
  end

  def follow!(other_user)
    relationships.create!(neighbor_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.where(neighbor_id: other_user.id).first.destroy
  end
end
