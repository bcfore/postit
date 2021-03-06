class CategoriesController < ApplicationController
  # before_action :require_user, except: [:show]
  before_action :require_admin, except: [:show]

  def show
    # @category = Category.find params[:id]
    @category = Category.find_by slug: params[:id]
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(cat_params)

    if @category.save
      flash['notice'] = "The category was created"
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def cat_params
    params.require(:category).permit(:name)
  end
end
