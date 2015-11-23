class ApplicationController < ActionController::API
  before_action :is_authourized?

  def is_authourized?
    # pass
  end
end
