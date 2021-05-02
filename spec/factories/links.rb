# frozen_string_literal: true

FactoryBot.define do
  factory :link do
    user
    original_url { 'https://google.com' }
    short_url { 'abcdef123' }
  end
end
