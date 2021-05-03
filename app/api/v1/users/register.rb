# frozen_string_literal: true

module V1
  module Users
    class Register < Grape::API
      helpers V1::Helpers::PublicEndpointHelper

      params do
        requires :first_name, type: String
        requires :last_name, type: String
        requires :email, regexp: Regexp::EMAIL
        requires :password, type: String
      end

      post do
        creator = ::Users::Operations::Create.new(dparams)
        if creator.run
          creator.user.reload

          create_auth_token(creator.user.uuid)
          :🎉
        else
          error!(
            {
              message: I18n.t('api.users.errors.invalid_information'),
              details: creator.user.errors.full_messages
            },
            response_code(:unprocessable_entity)
          )
        end
      rescue ::Users::Operations::EmailAlreadyInUseError
        error!(
          {
            message: I18n.t('api.users.errors.email_in_use')
          },
          response_code(:bad_request)
        )
      end
    end
  end
end
