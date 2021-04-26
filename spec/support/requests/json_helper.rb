# frozen_string_literal: true

module Requests
  module JsonHelpers
    def json_response
      @json_response ||= JSON.parse(response.body)
    end

    def response_message
      json_response.fetch('message')
    end
  end
end
