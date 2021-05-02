# frozen_string_literal: true

module V1
  module Helpers
    module AuthHelper
      def current_user
        @current_user ||= User.find_by!(uuid: decoded_auth_token['sub'])
      rescue ActiveRecord::RecordNotFound
        unauthorized!(I18n.t('api.model_errors.user_not_found'))
      end

      def decoded_auth_token
        @decoded_auth_token ||= decode_auth_token
      end

      def authenticated?
        return true if current_user

        unauthorized!
      end
    end
  end
end
