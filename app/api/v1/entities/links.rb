# frozen_string_literal: true

module V1
  module Entities
    class Links < Grape::Entity
      expose :id, :original_url, :shortened_url
    end
  end
end
