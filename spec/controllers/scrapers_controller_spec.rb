require 'rails_helper'

RSpec.describe ScrapersController, type: :controller do
  describe 'GET #data' do
    let(:url) { 'http://example.com' }

    it 'calls the ScrapeDataService and renders JSON response' do
      fields = { title: 'title_selector', description: 'desc_selector' }
      scraper = create(:scraper)
      allow_any_instance_of(ScrapeDataService).to receive(:call).and_return(scraper)

      get :data, params: { url: url, fields: fields }

      expect(response).to have_http_status(:ok)
      expect(response.body).to eq({ fields: { title: 'title_selector', description: 'desc_selector' } }.to_json)
    end

    it 'calls the ScrapeDataService and renders JSON response for tag meta' do
      meta_fields = { meta: %w[description] }
      description = 'Redmi 13C (Stardust Black, 4GB RAM, 128GB Storage)'
      scraper = create(:scraper, fields: { meta: { description: description } })
      allow_any_instance_of(ScrapeDataService).to receive(:call).and_return(scraper)

      get :data, params: { url: url, fields: meta_fields }

      expect(response).to have_http_status(:ok)
      expect(response.body).to eq({ fields: { meta: { description: description } } }.to_json)
    end
  end
end
