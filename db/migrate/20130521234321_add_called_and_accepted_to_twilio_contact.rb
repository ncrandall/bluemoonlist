class AddCalledAndAcceptedToTwilioContact < ActiveRecord::Migration
  def change
  	add_column :twilio_contacts, :contacted, :boolean, default: false
  	add_column :twilio_contacts, :accepted, :boolean, default: false
  end
end
