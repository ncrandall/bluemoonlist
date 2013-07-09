class AddRequestToRating < ActiveRecord::Migration
  def change
    add_column :ratings, :request_id, :integer
  end
end
