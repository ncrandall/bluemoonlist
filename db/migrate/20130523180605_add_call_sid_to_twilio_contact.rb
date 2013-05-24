class AddCallSidToTwilioContact < ActiveRecord::Migration
  def change
  	add_column :twilio_contacts, :call_sid, :string
  	add_index :twilio_contacts, :call_sid, unique: true
  	add_index :twilio_jobs, :call_sid, unique: true
  end
end
