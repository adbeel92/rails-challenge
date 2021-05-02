# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Visitor, type: :model do
  let!(:visitor) { create(:visitor) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:link_id) }
  end
end
