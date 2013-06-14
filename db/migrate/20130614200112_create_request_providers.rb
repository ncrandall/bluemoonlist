class CreateRequestProviders < ActiveRecord::Migration
  def change
    create_table :request_providers do |t|
      t.integer :request_id
      t.integer :provider_id
      t.integer :call_order
      t.boolean :contacted, default: false
      t.boolean :accepted, default: false

      t.timestamps
    end
  end
end
