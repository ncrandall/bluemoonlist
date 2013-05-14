class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.integer :status
      t.string :description

      t.timestamps
    end
  end
end
