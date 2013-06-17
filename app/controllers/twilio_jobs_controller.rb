class TwilioJobsController < ApplicationController
	skip_before_filter :verify_authenticity_token

	def create
		twilio_job = TwilioJob.new(twilio_job_params)
		twilio_job.build_contact_list(twilio_contact_params)

		if twilio_job.save
			@message = { success: true, id: twilio_job.id }
		else
			@message = { success: false, message: "Error creating job", errors: "#{twilio_job.errors.messages.to_json}" }
		end

		respond_to do |format|
			format.json { render json: @message }
		end
	end

	def update
	end

	private

	def twilio_job_params
		params.require(:twilio_job).permit(:status, :name, :phone, :status_callback, :contact_method)
	end

	def twilio_contact_params
		params.require(:twilio_job).permit(:providers => { :provider => [:name, :phone, :category, :call_order] })
	end
end
