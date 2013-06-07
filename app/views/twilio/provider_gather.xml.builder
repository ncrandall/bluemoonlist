xml.instruct!
xml.Response do
	xml.Dial timeout: 10, action: '/twilio/end_call.xml', timeLimit: 300 do
		xml.text! @number
	end
end