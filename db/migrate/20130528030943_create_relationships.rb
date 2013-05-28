class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.integer :user_id
      t.integer :neighbor_id

      t.timestamps
    end

    add_index :relationships, [ :user_id, :neighbor_id ], unique: true
  end
end
