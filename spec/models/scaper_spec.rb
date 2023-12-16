require 'rails_helper'

RSpec.describe Scraper, type: :model do

  describe 'create from hash' do
    let(:url) { 'http://example.com' }
    let(:fields) { { key1: 'value1', key2: 'value2' } }

    it 'calls create with the correct arguments' do
      allow(Scraper).to receive(:create)
      Scraper.create_from_hash(url, fields)

      expect(Scraper).to have_received(:create).with(url: url, fields: fields)
    end
  end
end
