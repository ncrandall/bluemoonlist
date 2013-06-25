class Micropost < ActiveRecord::Base
	default_scope -> { order('created_at DESC') }

	validates :description, presence: true, length: { maximum: 140 }
	validates :user_id, presence: true

	belongs_to :user

	def self.from_users_followed_by(user)
		select_sql = "SELECT neighbor_id FROM relationships WHERE user_id = :user_id"
		where("user_id IN (#{select_sql}) OR user_id = :user_id", user_id: user.id)
	end
end
