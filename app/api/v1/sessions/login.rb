# frozen_string_literal: true

module V1
  module Sessions
    class Login < Grape::API
      helpers V1::Helpers::PublicEndpointHelper

      desc 'Logs a user in by providing a JWT containing information about the user'
      params do
        requires :email, regexp: Regexp::EMAIL
        requires :password, type: String
      end

      post do
        # TODO
        true
      end
    end
  end
end
