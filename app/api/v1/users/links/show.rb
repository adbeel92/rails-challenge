# frozen_string_literal: true

module V1
  module Users
    module Links
      class Show < Grape::API
        desc 'Returns data regarding the specified link'
        get do
          authorize @link, :read?

          present @link, with: Entities::Link
        end
      end
    end
  end
end
