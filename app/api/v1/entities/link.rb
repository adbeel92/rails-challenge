# frozen_string_literal: true

module V1
  module Entities
    class Link < Grape::Entity
      expose :original_url, :shortened_url, :created_at

      expose :visitors,
             using: V1::Entities::Visitor
    end
  end
end
