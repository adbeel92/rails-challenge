# frozen_string_literal: true

module V1
  class Root < Grape::API
    # API V1 will always return JSON
    format :json

    # Prefix defines where the route will go
    prefix 'api'

    # Api version
    version 'v1', using: :path

    # Helper files for V1
    helpers V1::Helpers::ErrorResponseHelper
    helpers V1::Helpers::JwtHelper
    helpers V1::Helpers::AuthHelper
    helpers Components::Parameters

    # Predefined Pundit helpers
    helpers ::Pundit

    rescue_from Grape::Exceptions::ValidationErrors do |e|
      bad_request!(e.message)
    end
    rescue_from ActiveRecord::RecordNotFound do |_e|
      not_found!
    end
    rescue_from Pundit::NotAuthorizedError do |e|
      forbidden!(e.message)
    end
    rescue_from :all do |_e|
      internal_server_error!
    end

    # Ensure that every endpoint by default is protected
    before { authenticated? }

    mount V1::Sessions::Root
    mount V1::Users::Root
  end
end
