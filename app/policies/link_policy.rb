# frozen_string_literal: true

class LinkPolicy < ApplicationPolicy
  def read?
    record.user_id == user.id
  end

  def write?
    record.user_id == user.id
  end

  def delete?
    record.user_id == user.id
  end

  def list?
    true
  end

  def create?
    true
  end
end
