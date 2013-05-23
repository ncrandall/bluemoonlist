class TwilioWorker
	def begin_twilio_job(twilio_job)

		call_next_provider(twilio_job)
	end

  # Update the call list, send to call_next_provider
  def update_call_list(twilio_job, twilio_contact)
  	twilio_contact.called = true;
  	twilio_contact.save
  end

  # If there is a next provider sent to call_user
  def call_next_provider(twilio_job)
    twilio_job.twilio_contacts.each do |contact|
      if !contact.contacted?
      	# Make a request to Twilio
        make_call(contact.phone)
        return
      end
    end
  end

  # Fire off the call as a delayed job
  def call_user(twilio_job)
    url = ""
    make_call(twilio_job.phone, url)
  end

  # Make a call to the provider and connect the two
  def connect_user_to_provider
  
  end


  def make_call(to)
    from = '+14155150551'
    application_sid = "AP0b3c40b45634d668245976268b23b7c2"
    req_params = {
      From: from,
      To: to,
      ApplicationSid: application_sid
    }

    if Rails.env == "development"
    	
      url = "http://127.0.0.1:4567/make_call"
      RestClient.post url, req_params
    else
      client = TwilioDev.new

      account = client.account
      call = account.calls.create(req_params)
    end
  end
end