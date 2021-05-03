# frozen_string_literal: true

module Links
  module Operations
    class Update
      attr_reader :link

      def initialize(link:, original_url:)
        @link = link
        @original_url = URI.decode_www_form_component(original_url.strip)
      end

      def run
        assign_attributes
        return true unless link.changed?
        return false unless link.valid?

        link.save
      end

      private

      attr_reader :original_url

      def assign_attributes
        link.assign_attributes(
          original_url: original_url
        )
      end
    end
  end
end
