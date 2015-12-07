module Api
  class Tokenizer
    def self.encode(payload, exp = 12.hours.from_now)
      payload[:exp] = exp.to_i
      JWT.encode(payload, Rails.application.secrets.secret_key_base)
    end

    def self.decode(token)
      payload = JWT.decode(token, Rails.application.secrets.secret_key_base).
                first
      Api::V1::DecodedAuthToken.new(payload)
    rescue
      nil
    end
  end
end
