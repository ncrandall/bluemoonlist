class AddCallSidToTwilioJob < ActiveRecord::Migration
  def change
  	add_column :twilio_jobs, :call_sid, :string
  end
end
