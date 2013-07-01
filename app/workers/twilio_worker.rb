class TwilioWorker
	def begin_twilio_job(twilio_job)
    # execut based on type of job
    case twilio_job.contact_method
    when 0
		  update_call_list(twilio_job)
    when 1
      send_text(twilio_job)
    end
	end

  # Update the call list, send to call_next_provider
  def update_call_list(twilio_job, twilio_contact=nil)

    #if !twilio_contact.nil?
    #	twilio_contact.contacted = true;
    #	twilio_contact.save
    #end
    call_next_provider(twilio_job)
  end

  # If there is a next provider call them
  def call_next_provider(twilio_job)
    contact = get_next_uncontacted(twilio_job)

    if contact.nil?
      #if it gets here terminate TwilioJob. No more contacts exist
      twilio_job.delay.make_callback("done")
      twilio_job.status = :done
      twilio_job.save
    else
      contact.delay.make_callback("calling")
      path = "twilio/provider_twiml/#{contact.id}.xml"
      call_back_path = "twilio/provider_status_callback/#{contact.id}.xml"
      make_call(contact.phone, path, call_back_path)
    end
  end

  # Makes a REST call to either the dev twilio clone or
  # Twilio based on environment
  def make_call(to, path, call_back_path)
    from = '+18015131966'
    req_params = {
      from: from,
      to: to,
      url: "#{ENV['CALL_SERVICE_URL']}#{path}",
      if_machine: "Hangup",
      status_callback: "#{ENV['CALL_SERVICE_URL']}#{call_back_path}",
      timeout: 10

    }

    if Rails.env == "development"
      url = "http://127.0.0.1:4567/make_call"
      RestClient.post url, req_params
    else
      client = Twilio::REST::Client.new(ENV["TWILIO_SID"], ENV["TWILIO_TOKEN"])
      account = client.account
      call = account.calls.create(req_params)
    end
  end


  # Makes a REST call to twilio to send a text message to a provder
  def send_text(twilio_job)
    from = '+18015131966'

    req_params = {
      from: from,
      to: twilio_job.phone,
      status_callback: "#{ENV['CALL_SERVICE_URL']}twilio/provider_text_status_callback.xml",
      body: twilio_job.body
    }

    if Rails.env == "development"
      url = "http://127.0.0.1:4567/send_text"
      RestClient.post url, req_params
    else
      client = Twilio::REST::Client.new(ENV["TWILIO_SID"], ENV["TWILIO_TOKEN"])

      account = client.account
      message = account.sms.messages.create(req_params)
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