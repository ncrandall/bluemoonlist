class AddFieldsToTwilioHistory < ActiveRecord::Migration
  def change
  	add_column :twilio_histories, :account_sid, :string
  	add_column :twilio_histories, :to_zip, :string
  	add_column :twilio_histories, :from_state, :string
  	add_column :twilio_histories, :called, :string
  	add_column :twilio_histories, :from_country, :string
  	add_column :twilio_histories, :caller_country, :string
  	add_column :twilio_histories, :called_zip, :string
		add_column :twilio_histories, :direction, :string
  	add_column :twilio_histories, :from_city, :string
  	add_column :twilio_histories, :called_country, :string
  	add_column :twilio_histories, :duration, :string
  	add_column :twilio_histories, :caller_state, :string
  	add_column :twilio_histories, :called_state, :string
  	add_column :twilio_histories, :from, :string
  	add_column :twilio_histories, :caller_zip, :string
  	add_column :twilio_histories, :from_zip, :string
  	add_column :twilio_histories, :call_status, :string
  	add_column :twilio_histories, :to_city, :string
		add_column :twilio_histories, :to_state, :string
    add_column :twilio_histories, :to, :string
		add_column :twilio_histories, :call_duration, :string
		add_column :twilio_histories, :to_country, :string
		add_column :twilio_histories, :caller_city, :string
		add_column :twilio_histories, :api_version, :string
		add_column :twilio_histories, :caller, :string
		add_column :twilio_histories, :called_city, :string
  end
end
