class TwilioJobsController < ApplicationController
	skip_before_filter :verify_authenticity_token

	def create
		twilio_job = TwilioJob.new(twilio_job_params)
		twilio_job.build_contact_list(twilio_contact_params) unless params[:providers].nil?

		if twilio_job.save
			twilio_job.start_job
			@message = { success: true, id: twilio_job.id }
		else
			@message = { success: false, message: "Error creating job", errors: "#{twilio_job.errors.messages.to_json}" }
		end

		respond_to do |format|
			format.json { render json: @message }
		end
	end

	def update
		# TODO: Update this where clause to find params[:id] when the correct id is passed in from app
		twilio_job = TwilioJob.where(external_job_id: params[:id]).first
		
		params[:twilio_job][:status] = params[:twilio_job][:status].to_sym unless params[:twilio_job][:status].nil?

		if twilio_job.update_attributes(status_params)
			@message = { success: true, id: twilio_job.id }
		else
			@message = { success: false, message: "Error updating job", errors: "#{twilio_job.errors.messages.to_json}" }
		end

		respond_to do |format|
			format.json { render json: @message }
		end
	end

	private
	def status_params
		params.require(:twilio_job).permit(:status, :external_job_id)
	end

	def twilio_job_params
		params.require(:twilio_job).permit(:status, :name, :phone, :status_callback, :contact_method, :external_job_id, :body)
	end

	def twilio_contact_params
		params.require(:twilio_job).permit(:providers => { :provider => [:name, :phone, :category, :call_order, :external_contact_id] })
	end
end
