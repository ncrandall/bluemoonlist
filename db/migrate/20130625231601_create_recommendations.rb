class CreateRecommendations < ActiveRecord::Migration
  def change
    create_table :recommendations do |t|
      t.integer :user_id
      t.integer :provider_id
      t.integer :request_id

      t.timestamps
    end
  end
end
