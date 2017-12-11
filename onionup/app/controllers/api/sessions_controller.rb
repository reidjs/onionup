class Api::SessionsController < ApplicationController
  def create
    @user = User.find_by_credentials(
      params[:user][:username],
      params[:user][:password]
      )
    if @user 
      login(@user)
      render 'api/users/show'
    else
      render json: ["Invalid login credentials"], status: 422
    end
  end

  def destroy
    @user = current_user
    if current_user
      logout
      render 'api/users/show'
    else
      render json: ["Not logged in."], status: 404
    end
  end
end

