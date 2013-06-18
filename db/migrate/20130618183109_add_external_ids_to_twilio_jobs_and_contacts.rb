class AddExternalIdsToTwilioJobsAndContacts < ActiveRecord::Migration
  def change
  	rename_column :twilio_jobs, :request_id, :external_job_id
  	add_column :twilio_contacts, :external_contact_id, :integer
  end
end
