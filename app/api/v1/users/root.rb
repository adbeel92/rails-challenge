# frozen_string_literal: true

module V1
  module Users
    class Root < Grape::API
      resource :users do
        # Public API Endpoint
        mount Users::Register

        route_param :user_id, type: Integer do
          after_validation do
            @user = User.find_by!(id: dparams[:user_id])
          end

          # Private API Endpoints
          mount Users::Get
          mount V1::Users::Links::Root
        end
      end
    end
  end
end
