# frozen_string_literal: true

module Links
  module Operations
    class Create
      attr_reader :link

      def initialize(user:, original_url:)
        @user = user
        @original_url = URI.decode_www_form_component(original_url.strip)
      end

      def run
        build_link_with_attributes
        return false unless link.save

        assign_short_url
      end

      private

      attr_reader :user, :original_url

      def build_link_with_attributes
        @link = user.links.new(
          original_url: original_url
        )
      end

      def assign_short_url
        link.update(short_url: short_url)
      end

      def short_url
        ShortUrlBuilder.encode_link_url(link)
      end
    end
  end
end
