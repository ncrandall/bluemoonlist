xml.instruct!
xml.Response do
	xml.Gather timeout: 15, action: '/twilio/provider_gather.xml' do 
	xml.Say "Bluemoonlist.com haa a client on the line in need of #{@provider_cat},
		press 1 to speak with them otherwise hangup"
	end
	xml.Hangup
end