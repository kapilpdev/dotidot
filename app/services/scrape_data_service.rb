require 'open-uri'
require 'nokogiri'

class ScrapeDataService
  def initialize(url, fields)
    @url = url
    @fields = fields
  end

  def call
    html = HTTParty.get(@url).body
    doc = Nokogiri::HTML(html)
    result = fetch_data(doc)
    Scraper.create_from_hash(@url, result)
  rescue StandardError => e
    { error: e.message }
  end

  private

  def fetch_data(doc)
    result = {}
    @fields.each do |key, selector|
      result[key] = doc.css(selector).text.strip
    end
    result
  end
end
