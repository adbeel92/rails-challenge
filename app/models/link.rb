# frozen_string_literal: true

class Link < ApplicationRecord
  belongs_to :user

  has_many :visitors

  validates :user_id, presence: true
  validates :short_url,
            uniqueness: true
  validates :original_url,
            presence: true,
            uniqueness: true,
            format: { with: Regexp::URL }

  def shortened_url
    "#{ENV.fetch('APP_HOST')}/#{short_url}"
  end
end
