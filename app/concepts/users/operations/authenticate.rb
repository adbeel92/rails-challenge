# frozen_string_literal: true

module Users
  module Operations
    class Authenticate
      attr_reader :user

      def initialize(email:, password:)
        @email = email
        @password = password
      end

      def run
        find_user_by_email
        raise(InvalidEmailOrPasswordError) unless user&.authenticate(password)

        true
      end

      private

      attr_reader :email, :password

      def find_user_by_email
        @user = User.find_by('LOWER(email) = ?', email.downcase)
      end
    end

    class InvalidEmailOrPasswordError < StandardError; end
  end
end
