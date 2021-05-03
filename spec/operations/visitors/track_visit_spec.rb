# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Visitors::Operations::TrackVisit do
  describe '#run' do
    let(:link) { create(:link) }

    context 'When a visitor is new' do
      let(:request) do
        OpenStruct.new(
          remote_ip: '192.168.0.1',
          user_agent: 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7)'
        )
      end

      it 'should return true' do
        tracker = Visitors::Operations::TrackVisit.new(link: link, request: request)

        expect(tracker.run).to eq(true)
        expect(tracker.visitor.counter).to eq(1)
      end
    end

    context 'When a visitor already exists' do
      let!(:visitor) { create(:visitor, link: link, ip_address: '10.57.20.13', counter: 1) }
      let(:request) do
        OpenStruct.new(
          remote_ip: '10.57.20.13',
          user_agent: 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7)'
        )
      end

      it 'should raise error' do
        tracker = Visitors::Operations::TrackVisit.new(link: link, request: request)

        expect(tracker.run).to eq(true)
        expect(tracker.visitor.counter).to eq(2)
      end
    end
  end
end
