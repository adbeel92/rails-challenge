# frozen_string_literal: true

module V1
  module Users
    module Links
      class Root < Grape::API
        resource :links do
          # Public API Endpoint
          # --

          # Private API Endpoints
          mount Users::Links::Index
          mount Users::Links::Create

          route_param :link_id, type: Integer do
            after_validation do
              @link = current_user.links.find_by!(id: dparams[:link_id])
            end

            mount Users::Links::Show
            mount Users::Links::Update
            mount Users::Links::Delete
          end
        end
      end
    end
  end
end
