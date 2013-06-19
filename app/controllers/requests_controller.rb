class RequestsController < ApplicationController
  before_filter :authenticate_user!, except: [:callback]
  before_filter :correct_user, only: [:update, :destroy]
  skip_before_filter :verify_authenticity_token, only: [:callback]

  def index
    @request = Request.new
    @categories = Category.all
    @open_request = current_user.requests.where(status: [0, 1]).any?

    @filter ||= params[:filter]
    
    if @filter == 'self'
      @requests = current_user.requests
    else
      @requests = current_user.feed
    end
  end

  def show
    @request = Request.where(id: params[:id]).first
  end

  def create
    
    @request = current_user.requests.build(request_params).build_provider_list

    if @request.save
      @request.delay.make_calls
      flash[:success] = "Request successfully added"
      redirect_to request_path @request
    else
      flash[:error] = "There was a problem making request"
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
      
      if params[:request][:status] == :done
        twilio_worker = TwilioWorker.new
        twilio_worker.delay.send_text(request)
      end
      
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
      flash[:error] = "Error cancelling request"
    end
    redirect_to feed_path
  end

  def callback
    Rails.logger.info(params)

    request = Request.new
    request.add_history(request_history_params)

    respond_to do |format|
      format.all { render text: "Ok" }
    end
  end

  private

  def request_history_params
    params.permit!
  end

  def request_params
    params.require(:request).permit(:phone, :description, :category_id, :status,
      :street, :city, :state, :zip, :last_contacted_provider)
  end

  def correct_user
    @request = Request.where(id: params[:id]).first
    if @request.nil? || current_user != @request.user
      redirect_to root_path
    end
  end
end
