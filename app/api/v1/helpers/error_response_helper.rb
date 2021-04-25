# frozen_string_literal: true

module V1
  module Helpers
    module ErrorResponseHelper
      def unauthorized!(message = I18n.t('errors.unauthorized'))
        error!({ message: message }, response_code(:unauthorized))
      end

      def not_found!(message = I18n.t('errors.not_found'))
        error!({ message: message }, response_code(:not_found))
      end

      def bad_request!(message = I18n.t('errors.bad_request'))
        error!({ message: message }, response_code(:bad_request))
      end

      def internal_server_error!(message = I18n.t('errors.internal_server_error'))
        error!({ message: message }, response_code(:internal_server_error))
      end

      def forbidden!(message = I18n.t('errors.forbidden'))
        error!({ message: message }, response_code(:forbidden))
      end

      private

      def response_code(code_symbol)
        Rack::Utils::SYMBOL_TO_STATUS_CODE.fetch(code_symbol)
      end
    end
  end
end
