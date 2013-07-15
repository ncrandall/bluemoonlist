class CallJobsController < ApplicationController
	skip_before_filter :verify_authenticity_token

	def create
		call_job = CallJob.new(call_job_params)
		call_job.build_contact_list(twilio_contact_params) unless params[:call_job][:providers].nil?

		if call_job.save
			call_job.start_job
			@message = { success: true, id: call_job.id }
		else
			@message = { success: false, message: "Error creating job", errors: "#{call_job.errors.messages.to_json}" }
		end

		respond_to do |format|
			format.json { render json: @message }
		end
	end

	def update
		# TODO: Update this where clause to find params[:id] when the correct id is passed in from app
		call_job = CallJob.where(external_job_id: params[:id]).first
		
		params[:call_job][:status] = params[:call_job][:status].to_sym unless params[:call_job][:status].nil?

		if call_job.update_attributes(status_params)
			@message = { success: true, id: call_job.id }
		else
			@message = { success: false, message: "Error updating job", errors: "#{call_job.errors.messages.to_json}" }
		end

		respond_to do |format|
			format.json { render json: @message }
		end
	end

	private
	def status_params
		params.require(:call_job).permit(:status, :external_job_id)
	end

	def call_job_params
		params.require(:call_job).permit(:status, :name, :phone, :status_callback, :contact_method, :external_job_id, :body)
	end

	def twilio_contact_params
		params.require(:call_job).permit(:providers => { :provider => [:name, :phone, :category, :call_order, :external_contact_id] })
	end
end
