# frozen_string_literal: true

class Api < Grape::API
  mount V1::Root
end
