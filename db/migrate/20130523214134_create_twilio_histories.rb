class CreateTwilioHistories < ActiveRecord::Migration
  def change
    create_table :twilio_histories do |t|
      t.string :call_sid
      t.string :action

      t.timestamps
    end
  end
end
