# frozen_string_literal: true

module V1
  module Users
    module Links
      class Delete < Grape::API
        desc 'Deletes a link in the system'
        delete do
          authorize @link, :delete?

          @link.destroy
          present @link, with: Entities::Link
        end
      end
    end
  end
end
