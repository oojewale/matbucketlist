module Api
  module V1
    class UsersController < ApplicationController
      skip_before_action :set_current_user, :authenticate_request

      include Commons

      def index
        redirect_to "http://docs.matbucketlist.apiary.io/", status: 302
      end

      def create
        info = { username: (user_params[:username].downcase),
                 password: user_params[:password] }
        user = User.new(info)
        model_obj_saver(user)
      end
    end
  end
end
