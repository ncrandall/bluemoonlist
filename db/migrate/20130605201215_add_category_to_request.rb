class AddCategoryToRequest < ActiveRecord::Migration
  def change
  	add_column :requests, :category_id, :integer
  end
end
