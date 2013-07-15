class RenameTwilioJobToCallJob < ActiveRecord::Migration
  def change
    rename_table :twilio_jobs, :call_jobs
  end
end
