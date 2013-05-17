class TwilioWorker
	def make_call
		provider = Provider.first

		client = Twilio::REST::Client.new(ENV["TWILIO_SID"], ENV["TWILIO_TOKEN"])
		count = 0

		account = client.account
		call = account.calls.create({
			from: '+14155150551', 
			to: provider.phone, 
			application_sid: "AP0b3c40b45634d668245976268b23b7c2" 
		})
	end
end