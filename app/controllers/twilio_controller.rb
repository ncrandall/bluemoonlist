class TwilioController < ApplicationController
	skip_before_filter :verify_authenticity_token

	# twiml views

	def provider_twiml
		if params[:id]
			@contact = TwilioContact.where(id: params[:id]).first
			@contact.call_sid = params[:CallSid]
			@contact.save
		end
		params[:Action] = "Provider_Twiml"
		history = TwilioHistory.create(history_params)
    respond_to :xml
  end

  def user_twiml
  	if params[:job_id]
  		@job = TwilioJob.where(id: params[:job_id]).first
  		@job.status = :paused
  		@job.save
  	end
  	params[:Action] = "Provider_Twiml"
		history = TwilioHistory.create(history_params)
  	respond_to :xml
  end

	def user_provider_twiml
		respond_to :xml
	end

	# Twilio provides several parameters in their callbacks
	# http://www.twilio.com/docs/api/twiml/twilio_request#synchronous-request-parameters
	# We will be intersted in the following params
	# From, To, Sid

	def provider_status_callback
		params[:Action] = "Provider_Status_Callback" 
		history = TwilioHistory.create(history_params)
		contact = TwilioContact.where(call_sid: params[:CallSid]).first
		contact.contacted = true;
		contact.save

		twilio_worker = TwilioWorker.new
		if contact.accepted?
			twilio_worker.delay.call_user(contact.twilio_job)
		else
			twilio_worker.delay.update_call_list(contact.twilio_job)
		end

		respond_to :xml
	end

	def user_status_callback
		params[:Action] = "User_Status_Callback"
		history = TwilioHistory.create(history_params)
		
		# update this when we figure out how to connect the two

		respond_to :xml
	end

	def user_provider_status_callback
		params[:Action] = "User_Provider_Status_Callback"
		history = TwilioHistory.create(history_params)
		# connected both parties

	  # couldn't connect parties
		respond_to :xml
	end


	# gather action in Twiml
	def provider_gather

		params[:Action] = "Provider_Gather"
		TwilioHistory.create(history_params);

		contact = TwilioContact.where(call_sid: params[:CallSid]).first

		
		if params[:Digits] == '1'
			contact.accepted = true
			contact.save
		end

		respond_to :xml
	end

	def user_gather
		# get user decision to connect / continue 

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
