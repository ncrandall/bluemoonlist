class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.string :description
      t.integer :provider_id
      t.float :rating

      t.timestamps
    end
  end
end
