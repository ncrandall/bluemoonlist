class AddStatusCallbackToTwilioJobs < ActiveRecord::Migration
  def change
    add_column :twilio_jobs, :status_callback, :string
  end
end
