module Api
  class Tokenizer
    SECRET = Rails.application.secrets.secret_key_base

    def self.encode(payload, exp = 12.hours.from_now)
      payload[:exp] = exp.to_i
      JWT.encode(payload, SECRET, "HS256")
    end

    def self.decode(token)
      payload = JWT.decode(token, SECRET, true, algorithm: "HS256")
      payload[0]
    rescue JWT::ExpiredSignature
      nil
    end
  end
end
