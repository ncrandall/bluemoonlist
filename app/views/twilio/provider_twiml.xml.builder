xml.instruct!
xml.Response do
	xml.Say "Blue moon list dot com has a client on the line in need of #{@provider_cat}"
	xml.Gather action: "/twilio/provider_gather/#{@provider_id}.xml" do 
		xml.Say voice: "woman" do
			xml.text!  "press 1 to connect, otherwise hangup"
		end
	end
	xml.Say "Goodbye!"
	xml.Hangup
end