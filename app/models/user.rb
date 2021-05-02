# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  validates :first_name, :last_name, presence: true
  validates :email,
            presence: true,
            uniqueness: {
              case_sensitive: false
            }, format: { with: Regexp::EMAIL }
  validates :password,
            length: { in: 6..32 }
end
