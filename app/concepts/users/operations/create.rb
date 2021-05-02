# frozen_string_literal: true

module Users
  module Operations
    class Create
      attr_reader :user

      def initialize(args)
        @first_name = args[:first_name]
        @last_name = args[:last_name]
        @email = args[:email]
        @password = args[:password]
      end

      def run
        raise(EmailAlreadyInUseError) if users_exists_with_email?

        build_user_with_attributes
        return false unless user.valid?

        user.save
      end

      private

      attr_reader :first_name, :last_name, :email, :password

      def users_exists_with_email?
        User.find_by('LOWER(email) = ?', email.downcase).present?
      end

      def build_user_with_attributes
        @user = User.new(
          first_name: first_name,
          last_name: last_name,
          email: email,
          password: password
        )
      end
    end

    class EmailAlreadyInUseError < StandardError; end
  end
end
