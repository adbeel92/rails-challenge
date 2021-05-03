# frozen_string_literal: true

module V1
  module Users
    module Links
      class Update < Grape::API
        desc 'Updates an existing link within the system belonging to the logged in user'
        params do
          requires :original_url, type: String
        end

        put do
          authorize @link, :write?

          updater = ::Links::Operations::Update.new(link: @link, original_url: dparams[:original_url])
          if updater.run
            present updater.link, with: Entities::Link
          else
            error!(
              {
                message: I18n.t('api.links.errors.invalid_information'),
                details: updater.link.errors.full_messages
              },
              response_code(:unprocessable_entity)
            )
          end
        end
      end
    end
  end
end
