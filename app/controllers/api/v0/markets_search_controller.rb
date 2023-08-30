class Api::V0::MarketsSearchController < ApplicationController
  def index
    @markets = MarketSearchFacade.search_markets(params[:name], params[:city], params[:state])
    render json: MarketSerializer.new(@markets)
  end
end