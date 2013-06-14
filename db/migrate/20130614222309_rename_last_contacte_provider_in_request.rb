class RenameLastContacteProviderInRequest < ActiveRecord::Migration
  def change
  	remove_column :requests, :last_contacted_provider, :string
  	add_column :requests, :last_contacted_provider_id, :integer
  end
end
