class AddCategoryAndProviderToScores < ActiveRecord::Migration
  def change
  	add_column :scores, :provider_id, :integer
  	add_column :scores, :category_id, :integer

  	add_index :scores, [:category_id, :provider_id], unique: true
  end
end
