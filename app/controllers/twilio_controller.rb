class TwilioController < ApplicationController
	skip_before_filter :verify_authenticity_token

	# first request when provider answers a call
	def provider_twiml

		# get contact and set the call_sid
		contact = TwilioContact.where(id: params[:id]).first
		contact.call_sid = params[:CallSid]
		contact.save
		
		# get the provider category for TwiML file
		category = contact.category
		prefix = "an"
		prefix = "a" unless category =~ /^[aeiou]/

		# instance vars used in twiml file
		@provider_cat = "#{prefix} #{category}"
		@provider_id = contact.id

		# save request to history
		params[:Action] = "Provider_Twiml"
		history = TwilioHistory.create(history_params)
    
    respond_to :xml
  end

	# gathers input from the provider phone call
	def provider_gather

		contact = TwilioContact.where(id: params[:id]).first

		# determine if the provider wants to talk to client
		if params[:Digits] == '1'
			contact.delay.make_callback("paused")
			contact.accepted = true
			contact.save
			@number = contact.twilio_job.phone
		else
			render 'end_call'
		end

		# save request to history
		params[:Action] = "Provider_Gather"
		TwilioHistory.create(history_params);

		respond_to :xml
	end

	
	def provider_status_callback
		
		# save that we contacted the provider
		contact = TwilioContact.where(id: params[:id]).first
		contact.contacted = true
		contact.save

		twilio_worker = TwilioWorker.new
		
		# if the call was accepted update the request status
		if !contact.accepted?
			twilio_worker.delay.update_call_list(contact.twilio_job)
		end

		# save request to history
		params[:Action] = "Provider_Status_Callback" 
		history = TwilioHistory.create(history_params)

		respond_to :xml
	end



	def end_call

		@text = 'Goodbye'

		status = params['DialCallStatus']

		# set the text of the twiml according to answer status
		if !status.nil?
			if status == 'busy' || status == "no-answer"
				@text = "Unable to contact client, we will try again later. Goodbye"
			end
		end

		respond_to :xml
	end

	def provider_text_status_callback
		
		# TODO: save to provider that a text was sent to him based on success or not 
		params[:Action] = "Provider_Text_Status_Callback"
		history = TwilioHistory.create(history_params)

		respond_to :xml
	end

	private 
	
	def tmp_history_params
		params.permit!
	end

	def history_params

		post_params = [ :Action, :AccountSid,	:ToZip,	:FromState,	:Called,
			:FromCountry,	:CallerCountry,	:CalledZip,	:Direction,	:FromCity,
			:CalledCountry,	:Duration, :CallerState, :CallSid, :CalledState,
			:From, :CallerZip, :FromZip, :CallStatus, :ToCity, :ToState,
			:To, :CallDuration, :ToCountry,	:CallerCity, :ApiVersion,	:Caller,
			:CalledCity, :Digits ]

		params.permit(post_params)

		ret_params = {}

		post_params.each do |p|
			ret_params[p.to_s.underscore.to_sym] = params[p]

		end
		
		ret_params
	end

end
