# frozen_string_literal: true

module V1
  module Users
    module Links
      class Create < Grape::API
        desc 'Creates a new link for the logged in user'
        params do
          requires :original_url, type: String
        end

        post do
          authorize Link, :create?

          creator = ::Links::Operations::Create.new(user: current_user, original_url: dparams[:original_url])
          if creator.run
            present creator.link, with: Entities::Link
          else
            error!(
              {
                message: I18n.t('api.links.errors.invalid_information'),
                details: creator.link.errors.full_messages
              },
              response_code(:unprocessable_entity)
            )
          end
        end
      end
    end
  end
end
