class RenameTypeToContactTypeInTwilioJob < ActiveRecord::Migration
  def change
  	rename_column :twilio_jobs, :type, :contact_method
  end
end
