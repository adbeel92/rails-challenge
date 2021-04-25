# frozen_string_literal: true

module V1
  module Helpers
    module JwtHelper
      JWT_HMAC_SECRET = ENV['JWT_HMAC_SECRET']
      JWT_ALGORITHM = ENV['JWT_ALGORITHM']
      AUTHORIZATION_HEADER = 'X-Authorization'

      def create_auth_token(user_uuid)
        token = JWT.encode(
          build_token_data(user_uuid),
          JWT_HMAC_SECRET,
          JWT_ALGORITHM
        )

        header(AUTHORIZATION_HEADER, "Bearer #{token}")
      end

      def decode_auth_token
        unauthorized!(I18n.t('errors.token_not_found')) if headers[AUTHORIZATION_HEADER].blank?

        decoded_token = JWT.decode(
          headers[AUTHORIZATION_HEADER].split.last,
          JWT_HMAC_SECRET,
          true,
          {
            algorithm: JWT_ALGORITHM,
            iss: iss_value,
            verify_iss: true
          }
        )

        decoded_token.first
      rescue JWT::ExpiredSignature
        unauthorized!(I18n.t('errors.token_expired'))
      rescue JWT::InvalidIssuerError
        unauthorized!(I18n.t('errors.invalid_issuer'))
      rescue JWT::DecodeError => e
        unauthorized!(I18n.t('errors.invalid_token_structure'))
      end

      private

      def build_token_data(user_uuid)
        current_time = Time.current.to_i

        {
          'iss': iss_value,
          'iat': current_time,
          'exp': current_time + 48.hours,
          'sub': user_uuid
        }
      end

      def iss_value
        "KrediChallenge-#{ENV['RAILS_ENV']}"
      end
    end
  end
end
