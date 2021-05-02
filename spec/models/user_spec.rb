# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { create(:user) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email).ignoring_case_sensitivity }
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_length_of(:password).is_at_least(6) }
    it { is_expected.to validate_length_of(:password).is_at_most(32) }
    it { is_expected.to_not allow_value('anything').for(:email) }
    it { is_expected.to_not allow_value('test@test').for(:email) }
    it { is_expected.to_not allow_value('12345').for(:password) }
    it { is_expected.to_not allow_value('123456789012345678901234567890123').for(:password) }
  end
end
