class RenameTwilioJobIdToCallJobId < ActiveRecord::Migration
  def change
    rename_column :twilio_contacts, :twilio_job_id, :call_job_id
  end
end
