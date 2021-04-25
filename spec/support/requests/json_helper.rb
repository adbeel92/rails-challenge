# spec/support/requests/json_helpers.rb

module Requests
  module JsonHelpers
    def json_response
      @hash ||= JSON.parse(response.body)
    end

    def response_message
      json_response.fetch('message')
    end
  end
end
