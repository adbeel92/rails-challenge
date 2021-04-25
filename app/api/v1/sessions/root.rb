# frozen_string_literal: true

module V1
  module Sessions
    class Root < Grape::API
      resource :sessions do
        # Public Endpoints
        mount Sessions::Login
      end
    end
  end
end
