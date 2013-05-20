class CreateTwilioContacts < ActiveRecord::Migration
  def change
    create_table :twilio_contacts do |t|
      t.string :name
      t.string :phone
      t.integer :call_order
      t.integer :twilio_job_id

      t.timestamps
    end
  end
end
