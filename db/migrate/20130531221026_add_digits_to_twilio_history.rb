class AddDigitsToTwilioHistory < ActiveRecord::Migration
  def change
  	add_column :twilio_histories, :digits, :string
  end
end
