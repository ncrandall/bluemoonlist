xml.instruct!
xml.Response do
	xml.Gather timeout: 15, action: '/twilio/provider_gather.xml' do 
	xml.Say voice: "woman" "Blue moon list dot com has a client on the line 
		in need of #{@provider_cat}, press 1 to connect, otherwise hangup"
	end
	xml.Hangup
end