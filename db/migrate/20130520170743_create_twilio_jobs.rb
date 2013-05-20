class CreateTwilioJobs < ActiveRecord::Migration
  def change
    create_table :twilio_jobs do |t|
    	t.string :name
      t.string :phone
      t.integer :status

      t.timestamps
    end
  end
end
