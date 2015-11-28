class Api::V1::UsersController < ApplicationController
  skip_before_action :set_current_user, :authenticate_request

  include Commons

  def create
      info = { username: (user_params[:username].downcase), password: user_params[:password] }
      user = User.new(info)
      model_obj_saver(user)
  rescue
    render json: { error: "Cannot create user." }, status: 403
  end
end
