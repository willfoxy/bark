class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit]

  def new
    @user = User.new
  end

  def show
    @woof = Woof.new
    @relationship = Relationship.where(
    follower_id: current_user.id,
    followed_id: @user.id
    ).first_or_initialize if current_user
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to @user, notice: "Thank you for signing up"
    else
      render 'new'
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:username,:name,:email,:password, :password_confirmation,:avatar_url)
    end
end
