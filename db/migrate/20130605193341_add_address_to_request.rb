class AddAddressToRequest < ActiveRecord::Migration
  def change
  	add_column :requests, :street, :string
  	add_column :requests, :city, :string
  	add_column :requests, :state, :string
  	add_column :requests, :zip, :string
  end
end
