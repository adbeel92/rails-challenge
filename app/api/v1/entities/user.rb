# frozen_string_literal: true

module V1
  module Entities
    class User < Grape::Entity
      expose :id, :uuid, :email, :first_name, :last_name
    end
  end
end
