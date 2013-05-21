class RequestsController < ApplicationController
  def index
    @request = Request.new
    @requests = Request.all
  end

  def show
    @request = Request.where(id: params[:id]).first
  end

  def create
    @request = current_user.requests.build(request_params)
    send_twilio_job(@request) 
    if @request.save
      flash[:success] = "Request successfully added"
    else
      flash[:error] = "Unable to create Request"
    end
      redirect_to requests_path
  end

  #def edit
  #end

  #def update
  #end

  def destroy
    @request = Request.where(id: params[:id]).first
    @request.status = :cancelled
    if @request.save
      flash[:success] = "Request successfully canceled"
    else
      flash[:success] = "Error cancelling request"
    end
    redirect_to requests_path
  end


  def call_provider
    respond_to :xml
  end


  private

  def request_params
    params.require(:request).permit(:phone, :description)
  end

  def send_twilio_job(request)
    twilio_job = request.build_twilio_job(
        name: current_user.name,
        phone: @request.phone,
        status: 0
    )

    # Temporary List Generator
    cnt = 0
    providers = Provider.joins(:categories).where(:categories => {name: "Plumber"})
    providers.each do |p|
      cnt += 1
      twilio_job.twilio_contacts.build(name: p.name, phone: p.phone, call_order: cnt)
    end

    request
  end
end
