class RequestsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @requests = current_user.feed
  end

  def show
    @request = Request.where(id: params[:id]).first
  end

  def create
    @request = current_user.requests.build(request_params)
    @request = build_twilio_job(@request) 
    if @request.save
      twilio_worker = TwilioWorker.new
      twilio_worker.delay.begin_twilio_job(@request.twilio_job)
      flash[:success] = "Request successfully added"
      redirect_to request_path @request
    else
      @requests = Request.where(user_id: current_user.id)
      redirect_to feed_path
    end
  end

  #def edit
  #end

  def update
    request = current_user.requests.where(id: params[:id]).first

    # convert status param to symbol
    params[:request][:status] = params[:request][:status].to_sym unless 
      params[:request][:status].nil?

    if request.update_attributes(request_params)
      flash[:success] = "Upated your request successfully"
    else
      flash[:error] = "There was an error updating request"
    end

    respond_to do |format|
      format.html { redirect_to request_path(request) }
      format.js
    end
  end

  def destroy
    @request = current_user.requests.where(id: params[:id]).first

    if @request.destroy
      flash[:success] = "Request successfully canceled"
    else
      flash[:success] = "Error cancelling request"
    end
    redirect_to feed_path
  end


  private

  def request_params
    params.require(:request).permit(:phone, :description, :category_id, :status,
      :street, :city, :state, :zip)
  end

  def build_twilio_job(request)
    twilio_job = request.build_twilio_job(
        name: current_user.full_name,
        phone: request.phone,
        status: 0
    )

    # Temporary List Generator
    cnt = 0
    providers =  Provider.where(id: Score.where(category_id: request.category_id))
    providers.each do |p|
      cnt += 1
      twilio_job.twilio_contacts.build(
        name: p.name, 
        phone: p.phone,
        category: p.name,
        call_order: cnt
      )
    end

    request
  end
end
