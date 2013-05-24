class TwilioController < ApplicationController
	skip_before_filter :verify_authenticity_token

	# twiml views

	def provider_twiml
		if params[:id]
			@contact = TwilioContact.where(id: params[:id]).first
			@contact.call_sid = params[:CallSid]
			@contact.save
		end
    respond_to :xml
  end

  def user_twiml
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

		history = TwilioHistory.new(call_sid: params[:CallSid], action: "Provider_Status_Callback")
		history.save
		# provider answered

		# provider didn't answer
		respond_to :xml
	end

	def user_status_callback
		
		history = TwilioHistory.new(call_sid: params[:CallSid], action: "User_Status_Callback")
		history.save
		# user answered

		# user didn't answer
		respond_to :xml
	end

	def user_provider_status_callback

		history = TwilioHistory.new(call_sid: params[:CallSid], action: "User_Provider_Status_Callback")
		history.save
		# connected both parties

	  # couldn't connect parties
		respond_to :xml
	end


	# gather action in Twiml
	def provider_gather

		@contact = TwilioContact.where(call_sid: params[:CallSid]).first

		twilio_worker = TwilioWorker.new
		
		if params[:Digits] == '1'
			@contact.accepted = true
			@contact.save
			twilio_worker.delay.call_user(@contact.twilio_job)
		else
			twilio_worker.delay.call_next_provider(@contact.twilio_job)
		end

		respond_to :xml
	end

	def user_gather

	end
end
