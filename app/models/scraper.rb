class Scraper < ApplicationRecord
  serialize :fields, Hash

  def self.create_from_hash(url, fields)
    create(url:, fields:)
  end
end
