# frozen_string_literal: true

RSpec.shared_context 'auth_context' do
  def build_token_data(user)
    current_time = Time.current.to_i
    {
      iss: "RailsChallenge-#{ENV['RAILS_ENV']}",
      iat: current_time,
      exp: 1.hour.from_now.to_i,
      sub: user.uuid
    }
  end

  def auth_header(user = nil, data = nil)
    user = create(:user) if user.nil?
    data = build_token_data(user) if data.nil?

    token = JWT.encode(data, ENV.fetch('JWT_HMAC_SECRET', '$3cR3t'), ENV.fetch('JWT_ALGORITHM', 'HS256'))

    { 'X-Authorization': "Bearer #{token}" }
  end
end
