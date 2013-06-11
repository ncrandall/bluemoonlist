class AddLastContactedProviderToRequests < ActiveRecord::Migration
  def change
    add_column :requests, :last_contacted_provider, :string
  end
end
