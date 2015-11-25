class Api::V1::UsersController < ApplicationController
  skip_before_action :set_current_user, :authenticate_request

  def create
    info = { username: params[:username], password: params[:password] }
    user = User.new(info)
    if user.save
      render json: { response: "User successfully created!" }, status: :created
    else
      render json: { error: "Could not create user." }, status: 501
    end
  end
end
