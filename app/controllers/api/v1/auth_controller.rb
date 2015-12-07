module Api
  module V1
    class AuthController < ApplicationController
      skip_before_action :authenticate_request, only: [:login,
                                                       :invalid_endpoint]

      include Commons

      def login
        user = User.find_by_credentials((user_params[:username].downcase),
                                        user_params[:password]
                                       )
        if user
          render json: { auth_token: user.generate_auth_token }, status: 200
        else
          render json: { error: "Invalid login credentials" }, status: 401
        end
      end

      def logout
        list_token = { encrypted_token: coded_token }
        if Blacklist.create(list_token)
          render json: { response: "Logged out!" }, status: 200
        end
      end

      def invalid_endpoint
        render json: { error: "Specified endpoint does not exist.
                              Please check the API doc for clarification." },
               status: 404
      end
    end
  end
end
