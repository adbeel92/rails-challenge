# frozen_string_literal: true

module Visitors
  module Operations
    class TrackVisit
      attr_reader :visitor

      def initialize(link:, request:)
        @link = link
        @request = request
      end

      def run
        find_or_initialize_visitor
        assign_attributes
        increment_counter

        visitor.save
      end

      private

      attr_reader :link, :request

      def find_or_initialize_visitor
        @visitor = link.visitors.find_or_initialize_by(
          ip_address: request.remote_ip
        )
      end

      def assign_attributes
        return unless visitor.new_record?

        visitor.assign_attributes(
          user_agent: request.user_agent,
          os: operating_system
        )
      end

      def increment_counter
        visitor.counter += 1
      end

      def operating_system
        case request.user_agent.to_s.downcase
        when /mac/i then 'Mac'
        when /windows/i then 'Windows'
        when /linux/i then 'Linux'
        when /unix/i then 'Unix'
        else 'Unknown'
        end
      end
    end
  end
end
