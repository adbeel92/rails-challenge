# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::Operations::Authenticate do
  describe '#run' do
    context 'When a user exists' do
      let!(:user) { create(:user, password: 'password123') }

      it 'should return build the user when password match' do
        user.reload
        authenticator = Users::Operations::Authenticate.new(email: user.email, password: 'password123')

        expect(authenticator.run).to eq(true)
        expect(authenticator.user.class).to eq(User)
        expect(authenticator.user.email).to eq(user.email)
      end

      it 'should raise error when password does not match' do
        expect { Users::Operations::Authenticate.new(email: user.email, password: 'invalid pw').run }
          .to raise_error(Users::Operations::InvalidEmailOrPasswordError)
      end
    end

    context 'When the user does not exist' do
      it 'should raise error' do
        expect { Users::Operations::Authenticate.new(email: 'example@domain.com', password: 'invalid pw').run }
          .to raise_error(Users::Operations::InvalidEmailOrPasswordError)
      end
    end
  end
end
