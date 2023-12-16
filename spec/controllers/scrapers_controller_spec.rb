# spec/controllers/scrapers_controller_spec.rb

require 'rails_helper'

RSpec.describe ScrapersController, type: :controller do
  describe 'GET #data' do
    let(:url) { 'http://example.com' }
    let(:fields) { { 'title' => 'title_selector', 'description' => 'desc_selector', 'meta' => ['author', 'keywords'] } }
    let(:scraper) {create(:scraper)}

    it 'calls the ScrapeDataService and renders JSON response' do
      scraper = create(:scraper)
      allow_any_instance_of(ScrapeDataService).to receive(:call).and_return(scraper)

      get :data, params: { url: url, fields: fields }

      expect(response).to have_http_status(:ok)
      expect(response.body).to eq({"fields":{"title":"title_selector","description":"desc_selector"} }.to_json)
    end

    it 'calls the ScrapeDataService and renders JSON response for tag meta' do
      meta_fields = { 'meta' => ['author', 'keywords'] }
      scraper = create(:scraper, fields: {"meta"=>{ "description"=>"Redmi 13C (Stardust Black, 4GB RAM, 128GB Storage)"}})
      allow_any_instance_of(ScrapeDataService).to receive(:call).and_return(scraper)

      get :data, params: { url: url, fields: meta_fields }

      expect(response).to have_http_status(:ok)
      expect(response.body).to eq({"fields":{"meta"=>{ "description"=>"Redmi 13C (Stardust Black, 4GB RAM, 128GB Storage)"}}}.to_json)
    end
  end
end
