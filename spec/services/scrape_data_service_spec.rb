require 'rails_helper'

RSpec.describe ScrapeDataService do
  let(:url) { 'http://example.com' }
  let(:fields) { { 'meta' => ['author', 'keywords'] } }
  let(:data_fields) { { title: 'title_selector', description: 'desc_selector' } }
  let(:html_content) { '<html><head><title>Title</title><meta name="author" content="Author"></head><body></body></html>' }

  describe '#call' do
    before do
      allow(HTTParty).to receive(:get).with(url).and_return(double('response', body: html_content))
      allow(Nokogiri::HTML).to receive(:parse).with(html_content).and_return(Nokogiri::HTML(html_content))
    end

    it 'fetches and parses the HTML, creates a Scraper instance, and caches the result for meta tag' do
      allow(Scraper).to receive(:create_from_hash).with(url, title: 'Title', description: '', meta: { author: 'Author', keywords: nil })

      expect(Rails.cache).to receive(:fetch).with("#{url}/meta", expires_in: 1.hour)

      service = ScrapeDataService.new(url, fields)
      service.call
    end

    it 'fetches and parses the HTML, creates a Scraper instance, and caches the result for data' do

      allow(Scraper).to receive(:create_from_hash).with(url, title: 'Title', description: '')

      expect(Rails.cache).to receive(:fetch).with("#{url}/data", expires_in: 1.hour)

      service = ScrapeDataService.new(url, data_fields)
      service.call
    end
  end
end
