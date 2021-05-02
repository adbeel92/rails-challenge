# frozen_string_literal: true

FactoryBot.define do
  factory :visitor do
    link
    ip_address { '10.50.40.25' }
    user_agent { 'Mozilla/5.0' }
    os { 'MacOS' }
  end
end
