class RequestsController < ApplicationController
  def index
    @request = Request.new
    @requests = Request.all
  end

  def show
    @request = Request.where(id: params[:id]).first
  end

  def create
    @request = Request.new(request_params)

    if @request.save
      #fire off twilio delayed job
      twilio = TwilioWorker.new
      twilio.delay.make_call
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
end
