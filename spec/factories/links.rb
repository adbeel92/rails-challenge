# frozen_string_literal: true

FactoryBot.define do
  factory :link do
    user
    original_url { Faker::Internet.url }
    short_url { SecureRandom.uuid[0..7] }
  end
end
