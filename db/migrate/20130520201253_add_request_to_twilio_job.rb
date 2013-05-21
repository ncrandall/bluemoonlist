class AddRequestToTwilioJob < ActiveRecord::Migration
  def change
  	add_column :twilio_jobs, :request_id, :integer
  end
end
