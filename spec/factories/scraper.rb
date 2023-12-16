FactoryBot.define do
  factory :scraper do
    url { 'http://example.com' }
    fields { { 'title' => 'title_selector', 'description' => 'desc_selector' } }
  end
end