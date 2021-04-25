# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { 'email@domain.com' }
    password { 'password123' }
    first_name { 'Eduardo' }
    last_name { 'Arenas' }
  end
end
