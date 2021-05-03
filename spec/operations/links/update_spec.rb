# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Links::Operations::Update do
  describe '#run' do
    let(:link) { create(:link) }
    let(:user) { link.user }
    let(:payload) do
      {
        link: link,
        original_url: Faker::Internet.url
      }
    end

    context 'When a link is new' do
      it 'should return true' do
        updater = Links::Operations::Update.new(payload)

        expect(updater.run).to eq(true)
        expect(updater.link.class).to eq(Link)
        expect(updater.link.original_url).to eq(payload[:original_url])
      end

      it 'should return false' do
        tmp_payload = payload.dup
        tmp_payload[:original_url] = 'invalid_url'
        updater = Links::Operations::Update.new(tmp_payload)

        expect(updater.run).to eq(false)
      end
    end

    context 'When the original_url already exists' do
      let!(:tmp_link) { create(:link) }

      it 'should raise error' do
        tmp_payload = payload.dup
        tmp_payload[:original_url] = tmp_link.original_url
        updater = Links::Operations::Update.new(tmp_payload)

        expect(updater.run).to eq(false)
      end
    end
  end
end
