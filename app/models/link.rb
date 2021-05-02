# frozen_string_literal: true

class Link < ApplicationRecord
  belongs_to :user

  has_many :visitors

  validates :user_id, :short_url, presence: true
  validates :original_url,
            presence: true,
            format: { with: Regexp::URL }
end
