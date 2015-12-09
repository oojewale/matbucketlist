module Api
  class Tokenizer
    SECRET = Rails.application.secrets.secret_key_base
    # LEEWAY = 120

    def self.encode(payload, exp = 12.hours.from_now)
      payload[:exp] = exp.to_i
      JWT.encode(payload, SECRET, 'HS256')
    end

    def self.decode(token)
      # require "pry"; binding.pry
      # payload = JWT.decode(token, Rails.application.secrets.secret_key_base).first
      # Api::V1::DecodedAuthToken.new(payload)
      payload = JWT.decode(token, SECRET, true, { algorithm: 'HS256' })
      payload[0]
    rescue JWT::ExpiredSignature
      nil
    end
  end
end
