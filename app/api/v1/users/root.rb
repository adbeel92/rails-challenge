# frozen_string_literal: true

module V1
  module Users
    class Root < Grape::API
      resource :users do
        # Public API Endpoint
        mount Users::Register

        route_param :user_id, type: Integer do
          # Private API Endpoints
          mount Users::Get
        end
      end
    end
  end
end
