class RequestsController < ApplicationController
  before_filter :authenticate_user!, except: [:callback]
  before_filter :correct_user, only: [:update, :destroy]
  skip_before_filter :verify_authenticity_token, only: [:callback]

  def index
    @request = Request.open_request(current_user.id) || Request.new
    @categories = Category.all

    @requests = current_user.requests
  end

  def show
    @request = Request.where(id: params[:id]).first
    @recommendation = Recommendation.new
    @providers = Provider.joins(:scores).where(scores: { category_id: @request.category_id })

    respond_to do |format|
      format.html
      format.js
    end
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

  def update
    @request = current_user.requests.where(id: params[:id]).first

    # convert status param to symbol
    params[:request][:status] = params[:request][:status].to_sym unless 
      params[:request][:status].nil?

    @request.update_call_status(params[:request][:status])

    if @request.update_attributes(request_params)
      if params[:request][:send_text]
        @request.delay.send_text
      end
      
      flash[:success] = "Upated your request successfully"
    else
      flash[:error] = "There was an error updating request"
    end

    respond_to do |format|
      format.html { redirect_to @request }
      format.js { render 'show' }
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
    request = Request.new
    request.process_callback(request_history_params[:job])

    respond_to do |format|
      format.all { render text: "Ok" }
    end
  end

  private

  # TODO: Restrict this to safe params
  def request_history_params
    params.permit!
  end

  def request_params
    params.require(:request).permit(:phone, :description, :category_id, :status,
      :street, :city, :state, :zip, :last_contacted_provider_id)
  end

  def correct_user
    @request = Request.where(id: params[:id]).first
    if @request.nil? || current_user != @request.user
      redirect_to root_path
    end
  end
end
