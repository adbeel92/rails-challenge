# frozen_string_literal: true

Rails.application.routes.draw do
  get ':shortened_url', to: 'link#show'

  mount Api => ''
end
