module RequestHelper
  def gen_auth_token
    payload = { user_id: id }
    exp = Time.now
    Api::V1::Tokenizer.encode(payload,exp)
  end
end