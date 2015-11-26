class Api::V1::AuthController < ApplicationController
  skip_before_action :authenticate_request

  def login
    user = User.find_by_credentials((params[:username].downcase), params[:password])
    if user
      render json: { auth_token: user.generate_auth_token }
    else
      render json: { error: "Invalid login credentials" }, status: :unauthorized
    end
  end

  def logout
    list_token = { encrypted_token: coded_token }
    Blacklist.delete_old
    if Blacklist.create(list_token)
      render json: { response: "Logged out!" }, status: 200
    end
  rescue
    render json: { error: "Could not log you out" }
  end
end
