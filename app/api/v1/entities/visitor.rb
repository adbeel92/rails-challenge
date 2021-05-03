# frozen_string_literal: true

module V1
  module Entities
    class Visitor < Grape::Entity
      expose :id, :ip_address, :user_agent, :os, :counter
    end
  end
end
