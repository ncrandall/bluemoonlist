class TwilioWorker
	def make_call
		#provider = Provider.first
		phone = '801-508-4604'

		client = Twilio::REST::Client.new(ENV["TWILIO_SID"], ENV["TWILIO_TOKEN"])
		count = 0

		account = client.account
		call = account.calls.create('+14155150551', phone, "http://www.bluemoonlist.com/microposts/dialback.xml?phone_user=#{phone}&count=#{count}")
	end
end