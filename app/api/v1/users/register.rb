# frozen_string_literal: true

module V1
  module Users
    class Register < Grape::API
      helpers V1::Helpers::PublicEndpointHelper

      params do
        requires :first_name, type: String
        requires :last_name, type: String
        requires :email, regexp: Regexp::EMAIL
        requires :password, type: String
      end

      post do
        # TODO
        true
      end
    end
  end
end
