class RatingsController < ApplicationController

  def create
    @rating = Rating.new(rating_params)

    if @rating.save
      flash[:success] = "Successfully added rating"
    else
      flash[:success] = "Error adding rating"
    end

  end

  def destroy
    @rating = Rating.where(id: params[:id]).first

    if @rating.destroy
      flash[:success] = "Successfully deleted rating"
    else
      flash[:error] = "Error deleting rating"
    end
  end

  private

  def rating_params
    params.require("rating").permit(:description, :rating, :provider_id, :request_id)
  end
end
