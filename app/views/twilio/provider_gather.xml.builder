xml.instruct!
xml.Response do
	xml.Say voice: "woman" do 
		xml.text! "I will connect you now"
	end
	xml.Dial timeout: 10, action: '/twilio/end_call.xml', timeLimit: 300 do
		xml.text! @number
	end
end