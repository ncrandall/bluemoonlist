class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def show
    @category = Category.where(id: params[:id]).first
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      flash[:success] = "Category Successfully Created"
      redirect_to categories_path
    else
      flash[:error] = "Error Updating Category"
      render 'new'
    end
  end

  def edit
    @category = Category.where(id: params[:id]).first
  end

  def update
    @category = Category.where(id: params[:id]).first

    if @category.update_attributes(category_params)
      flash[:success] = "Updated Category Successfully"
      redirect_to categories_path
    else
      flash[:error] = "Error Updating Category"
      render 'edit'
    end
  end

  def destroy
    @category = Category.where(id: params[:id]).first

    if @category.destroy
      flash[:success] = "Category Successfully Deleted"
    else
      flash[:error] = "Error Deleting Category"
    end

    redirect_to categories_path
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
