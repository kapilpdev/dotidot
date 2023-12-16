require 'rails_helper'

RSpec.describe Scraper, type: :model do
  describe 'methods' do
    describe '.create_from_hash' do
      let(:url) { 'http://example.com' }
      let(:fields) { { key1: 'value1', key2: 'value2' } }

      it 'creates a new Scraper instance with the provided URL and fields' do
        expect(Scraper).to receive(:create).with(url: url, fields: fields)
        Scraper.create_from_hash(url, fields)
      end

      it 'returns the created Scraper instance' do
        scraper = double('Scraper')
        allow(Scraper).to receive(:create).and_return(scraper)

        expect(Scraper.create_from_hash(url, fields)).to eq(scraper)
      end
    end
  end
end
