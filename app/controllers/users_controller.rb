class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :require_same_user, except: [:new, :create, :show]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash['notice'] = "You've successfully registered!"
      session[:user_id] = @user.id
      redirect_to root_path
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @user.update(user_params)
      flash['notice'] = "Your profile was updated."
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end

  def set_user
    # user = User.find_by id: params[:id]
    user = User.find_by slug: params[:id]

    if user.nil?
      flash["error"] = "Unknown user id!"
      redirect_to root_path
    else
      # @user = User.find(params[:id])
      @user = user
    end
  end

  def require_same_user
    # unless current_user.id.to_s == params[:id]
    unless current_user == @user
      flash["error"] = "You cannot modify another user's profile!"
      redirect_to root_path
    end
  end
end
