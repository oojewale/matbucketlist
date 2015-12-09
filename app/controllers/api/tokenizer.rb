module Api
  class Tokenizer
    SECRET = Rails.application.secrets.secret_key_base

    def self.encode(payload, exp = 12.hours.from_now)
      payload[:exp] = exp.to_i
      JWT.encode(payload, SECRET, 'HS256')
    end

    def self.decode(token)
      # require "pry"; binding.pry
      # payload = JWT.decode(token, Rails.application.secrets.secret_key_base, true).
      #           first
      # Api::V1::DecodedAuthToken.new(payload)
      payload = JWT.decode(token, SECRET, true, { :algorithm => 'HS256' })
    rescue JWT::ExpiredSignature
      # nil
      :expired
    end
  end
end
