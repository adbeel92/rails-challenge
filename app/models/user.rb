# frozen_string_literal: true

class User < ApplicationRecord
  has_many :links

  validates :first_name, :last_name, presence: true
  validates :email,
            presence: true,
            format: { with: Regexp::EMAIL },
            uniqueness: {
              case_sensitive: false
            }
  validates :password,
            length: { in: 6..32 }

  has_secure_password
end
