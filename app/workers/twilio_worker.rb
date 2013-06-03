class TwilioWorker
	def begin_twilio_job(twilio_job)

		update_call_list(twilio_job)
	end

  # Update the call list, send to call_next_provider
  def update_call_list(twilio_job, twilio_contact=nil)

    #if !twilio_contact.nil?
    #	twilio_contact.contacted = true;
    #	twilio_contact.save
    #end
    call_next_provider(twilio_job)
  end

  # If there is a next provider sent to call_user
  def call_next_provider(twilio_job)
    contact = get_next_uncontacted(twilio_job)

    if contact.nil?
      #if it gets here terminate TwilioJob. No more contacts exist
      twilio_job.status = :done
      twilio_job.save
    else
      path = "twilio/provider_twiml/#{contact.id}"
      call_back_path = "twilio/provider_status_callback"
      make_call(contact.phone, path, call_back_path)
    end
  end

  # Fire off the call
  def call_user(twilio_job)
    path = "twilio/user_twiml"
    call_back_path = "twilio/user_status_callback"
    make_call(twilio_job.phone, path, call_back_path)
  end

  # Make a call to the provider and connect the two
  def connect_user_to_provider
    path = "twilio/user_provider_twiml"
    call_back_path = "twilio/user_provider_status_callback"
    make_call(twilo_job.phone, path, call_back_path)
  end


  # Makes a REST call to either the dev twilio clone or
  # Twilio based on environment
  def make_call(to, path, call_back_path)
    from = '+14155150551'
    req_params = {
      from: from,
      to: to,
      url: "http://morning-shelf-8847.herokuapp.com/#{path}",
      if_machine: "Hangup",
      status_callback: "http://morning-shelf-8847.herokuapp.com/#{call_back_path}",
      timeout: 10

    }

    if Rails.env == "development"
    	
      url = "http://127.0.0.1:4567/make_call"
      req_params[:url] = "http://localhost:3000/#{path}"
      req_params[:status_callback] = "http://localhost:3000/#{call_back_path}"
      RestClient.post url, req_params
    else
      client = Twilio::REST::Client.new(ENV["TWILIO_SID"], ENV["TWILIO_TOKEN"])

      account = client.account
      call = account.calls.create(req_params)
    end
  end

  private
  
  def get_next_uncontacted(twilio_job)
    twilio_job.twilio_contacts.each do |contact|
      if !contact.contacted?
        return contact
      end
    end
    nil
  end
end