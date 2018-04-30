class SearchesController < ApplicationController
  def search
  end

  def foursquare
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = 0OCCEMFIJVWMT1ZZCTMLY4CLFE2RIDHNRL02ILGNBPG0M0KE
      req.params['client_secret'] = OLDAYQI1WS1MHZ5V0SBJMKWOCAKBOUNLUDLGK34SWMYXMPZB
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'
    end
    body = JSON.parse(@resp.body)
    if @resp.success?
      @venues = body["response"]["venues"]
    else
      @error = body["meta"]["errorDetail"]
    end

  rescue Faraday::ConnectionFailed
  @error = "There was a timeout. Please try again."
  end
    render 'search'
  end
end
