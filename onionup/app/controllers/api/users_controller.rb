class Api::UsersController < ApplicationController
  def new
    @user = User.new(user_params)
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login(@user)
      render "api/users/show"
    else
      render json: @user.errors.full_messages, status: 422
    end
  end

  def index 
    render json: ["Please fill in the username"], status: 405
  end 

  private

  def user_params
    params.require(:user).permit(:password, :username)
  end
end
