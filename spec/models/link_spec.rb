# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Link, type: :model do
  let!(:link) { create(:link) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:user_id) }
    it { is_expected.to validate_presence_of(:short_url) }
    it { is_expected.to validate_presence_of(:original_url) }
    it { is_expected.to allow_value('http://google.com').for(:original_url) }
    it { is_expected.to_not allow_value('anything').for(:original_url) }
    it { is_expected.to_not allow_value('test@test').for(:original_url) }
    it { is_expected.to_not allow_value('12345').for(:original_url) }
  end
end
