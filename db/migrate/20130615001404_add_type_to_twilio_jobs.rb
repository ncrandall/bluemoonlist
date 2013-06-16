class AddTypeToTwilioJobs < ActiveRecord::Migration
  def change
    add_column :twilio_jobs, :type, :integer
  end
end
