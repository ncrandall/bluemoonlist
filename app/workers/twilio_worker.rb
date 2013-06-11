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

  # If there is a next provider call them
  def call_next_provider(twilio_job)
    contact = get_next_uncontacted(twilio_job)

    if contact.nil?
      #if it gets here terminate TwilioJob. No more contacts exist
      twilio_job.status = :done
      twilio_job.save
    else
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


  # Makes a REST call to twilio to send a text message to a provder
  def send_text(request)
    from = '+18015131966'

    str = "#{request.description}\n\n#{request.street}\n#{request.city} #{request.state}, #{request.zip}"

    req_params = {
      from: from,
      to: request.last_contacted_provider,
      status_callback: "http://morning-shelf-8847.herokuapp.com/twilio/provider_text_status_callback.xml",
      body: str
    }

    if Rails.env == "development"
      url = "http://127.0.0.1:4567/send_text"
      req_params[:status_callback] = "http://localhost:3000/twilio/provider_text_status_callback.xml"
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