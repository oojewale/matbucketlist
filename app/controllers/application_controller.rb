class ApplicationController < ActionController::API
  before_action :set_current_user, :authenticate_request

  rescue_from Api::NotAuthenticatedError do
    render json: { error: "Not Authenticated" }, status: 401
  end

  rescue_from Api::AuthenticationTimeoutError do
    render json: { error: "Auth token is expired or not present" }, status: 403
  end

  protected

  def coded_token
    request.headers["Authorization"]
  end

  def blacklisted?
    Blacklist.find_by(encrypted_token: coded_token)
  end

  def set_current_user
    if decoded_auth_token
      @current_user ||= User.find(decoded_auth_token["user_id"])
    end
  end

  def authenticate_request
    if auth_token_expired?
      fail Api::AuthenticationTimeoutError
    elsif !@current_user || blacklisted?
      fail Api::NotAuthenticatedError
    end
  end

  def decoded_auth_token
    if http_auth_header_content
      @decoded_auth_token ||= Api::Tokenizer.decode(http_auth_header_content)
    end
  end

  def auth_token_expired?
    decoded_auth_token.nil?
  end

  def http_auth_header_content
    return @http_auth_header_content if defined? @http_auth_header_content
    @http_auth_header_content = begin
      if request.headers["Authorization"].present?
        request.headers["Authorization"].split(" ").last
      end
    end
  end
end
