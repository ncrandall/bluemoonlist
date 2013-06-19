class CreateRequestHistories < ActiveRecord::Migration
  def change
    create_table :request_histories do |t|
      t.string :status
      t.integer :request_id
      t.integer :request_provider_id

      t.timestamps
    end
  end
end
