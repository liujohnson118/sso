class WelcomeController < ApplicationController
  before_action :authenticate_user!
  def index
  end
  def bitcoin_prices
    uri = URI('http://api.bitcoincharts.com/v1/weighted_prices.json')
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Post.new(uri)
    request["Content-Type"] = 'application/json'
    response = http.request(request)
    respond_to do |format|
      format.json { render json: response.body, root:false }
    end
  end
end
