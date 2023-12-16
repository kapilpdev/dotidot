require 'nokogiri'

class ScrapeDataService
  def initialize(url, fields)
    @url = url
    @fields = fields
  end

  def call
    data = @fields.include?('meta') ? 'meta' : 'data'
    Rails.cache.fetch("#{@url}/#{data}", expires_in: 1.hour) do
      html = HTTParty.get(@url).body
      doc = Nokogiri::HTML(html)
      result = fetch_data(doc)
      Scraper.create_from_hash(@url, result)
    end
  end

  private

  def fetch_data(doc)
    result = {}
    @fields.each do |key, selector|
      result[key] = doc.css(selector).text.strip
      result[key] = fetch_metadata(doc, selector) if key == 'meta'
    end
    result
  end

  def fetch_metadata(page, meta)
    meta_result = {}

    meta.each do |tag|
      meta_result[tag] = page.at("meta[name='#{tag}']")['content']
    end

    meta_result
  end
end
