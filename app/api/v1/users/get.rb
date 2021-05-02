# frozen_string_literal: true

module V1
  module Users
    class Get < Grape::API
      get do
        authorize @user, :read?
        present @user, with: Entities::User
      end
    end
  end
end
