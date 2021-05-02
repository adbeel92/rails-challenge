# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::Operations::Create do
  describe '#run' do
    let(:payload) do
      {
        first_name: 'Eduardo',
        last_name: 'Arenas',
        email: 'test@gmail.com',
        password: 'password123'
      }
    end

    context 'When a user is new' do
      it 'should return true' do
        authenticator = Users::Operations::Create.new(payload)

        expect(authenticator.run).to eq(true)
        expect(authenticator.user.class).to eq(User)
        expect(authenticator.user.email).to eq(payload[:email])
      end

      it 'should return false' do
        tmp_payload = payload.dup
        tmp_payload[:email] = 'invalid_email'
        authenticator = Users::Operations::Create.new(tmp_payload)

        expect(authenticator.run).to eq(false)
      end
    end

    context 'When the email already exists' do
      let!(:user) { create(:user) }

      it 'should raise error' do
        tmp_payload = payload.dup
        tmp_payload[:email] = user.email
        expect { Users::Operations::Create.new(tmp_payload).run }
          .to raise_error(Users::Operations::EmailAlreadyInUseError)
      end
    end
  end
end
