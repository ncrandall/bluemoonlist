class AddPhoneToRequest < ActiveRecord::Migration
  def change
  	add_column :requests, :phone, :string
  end
end
