class RequestsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :correct_user, only: [:update, :destroy]

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
    @request = current_user.requests.build(request_params)
    # @request = build_twilio_job(@request) 
    @request = build_provider_contact_list(@request)
    if @request.save
      # TODO: send a request to twilio subsystem to make a call 
      twilio_worker = TwilioWorker.new
      twilio_worker.delay.begin_twilio_job(@request.twilio_job)
      # end request to twilio subsystem

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


  private

  def request_params
    params.require(:request).permit(:phone, :description, :category_id, :status,
      :street, :city, :state, :zip, :last_contacted_provider)
  end

  def build_provider_contact_list(request)
    # Temporary Provider Contact List Generator

    providers = Provider.where(id: Score.where(category_id: request.category_id)).limit(3)

    cnt = 0
    providers.each do |p|
      request.request_providers.build(provider: p, call_order: cnt)
      cnt += 1
    end 

    request
  end

  # TODO: deprecate
  def build_twilio_job(request)
    twilio_job = request.build_twilio_job(
        name: current_user.full_name,
        phone: request.phone,
        status: 0
    )

    # Temporary List Generator
    cnt = 0
    providers =  Provider.where(id: Score.where(category_id: request.category_id))
    category = Category.where(id: request.category_id).first
    providers.each do |p|
      cnt += 1
      twilio_job.twilio_contacts.build(
        name: p.name, 
        phone: p.phone,
        category: category.name,
        call_order: cnt
      )
    end

    request
  end

  def correct_user
    @request = Request.where(id: params[:id]).first
    if @request.nil? || current_user != @request.user
      redirect_to root_path
    end
  end
end
