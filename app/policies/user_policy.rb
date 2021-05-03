# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  def read?
    user.id == record.id
  end
end
