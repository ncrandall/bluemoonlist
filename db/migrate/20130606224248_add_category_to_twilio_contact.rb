class AddCategoryToTwilioContact < ActiveRecord::Migration
  def change
  	add_column :twilio_contacts, :category, :string
  end
end
