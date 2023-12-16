class ScrapersController < ApplicationController
  def data
    url = params[:url]
    fields = params[:fields]
    result = ScrapeDataService.new(url, fields).call

    render json: result, serializer: ScraperSerializer
  end
end
