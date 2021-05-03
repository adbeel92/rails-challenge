# frozen_string_literal: true

module Links
  module Queries
    class LinkByShortUrl
      attr_reader :short_url

      def initialize(short_url:)
        @short_url = short_url.to_s.strip
      end

      def run
        Link.find_by!(id: decoded_link_url[:id])
      end

      private

      def decoded_link_url
        Links::Operations::ShortUrlBuilder.decode_link_url(short_url)
      end
    end
  end
end
