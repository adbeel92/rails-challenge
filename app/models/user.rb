# frozen_string_literal: true

class User < ApplicationRecord
  validates :email, :password, :first_name, :last_name, presence: true
  validates :email, uniqueness: {
    case_sensitive: false
  }, format: { with: Regexp::EMAIL }
end
