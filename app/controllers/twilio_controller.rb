class TwilioController < ApplicationController
	skip_before_filter :verify_authenticity_token
	# Twilio provides several parameters in their callbacks
	# http://www.twilio.com/docs/api/twiml/twilio_request#synchronous-request-parameters
	# We will be intersted in the following params
	# From, To, Sid

	def providers_status_callback

		# provider answered

		# provider didn't answer

	end

	def user_status_callback

		# user answered

		# user didn't answer

	end

	def user_provider_callback

		# connected both parties

	  # couldn't connect parties

	end

	def user_provider_twiml
		respond_to :xml
	end

	def provider_twiml
    respond_to :xml
  end

  def user_twiml
  	respond_to :xml
  end
end
