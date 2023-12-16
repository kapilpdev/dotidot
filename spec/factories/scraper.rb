FactoryBot.define do
  factory :scraper do
    url { 'http://example.com' }
    fields { { 'title' => 'title_selector', 'description' => 'desc_selector' } }
    # Add other attributes as needed
  end
end