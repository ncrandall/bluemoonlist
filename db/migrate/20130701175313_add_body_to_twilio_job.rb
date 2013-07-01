class AddBodyToTwilioJob < ActiveRecord::Migration
  def change
    add_column :twilio_jobs, :body, :string
  end
end
