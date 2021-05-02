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
        authenticator = ::Users::Operations::Authenticate.new(email: dparams[:email], password: dparams[:password])
        authenticator.run

        create_auth_token(authenticator.user.uuid)
        :🎉
      rescue ::Users::Operations::InvalidEmailOrPasswordError
        error!(
          {
            message: I18n.t('api.sessions.errors.login_failed')
          },
          response_code(:bad_request)
        )
      end
    end
  end
end
