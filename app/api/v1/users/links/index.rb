# frozen_string_literal: true

module V1
  module Users
    module Links
      class Index < Grape::API
        desc 'Returns all links for the logged in user'
        get do
          authorize Link, :list?

          present current_user.links, with: Entities::Link
        end
      end
    end
  end
end
