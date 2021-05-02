# frozen_string_literal: true

class Visitor < ApplicationRecord
  belongs_to :link

  validates :link_id, presence: true
end
