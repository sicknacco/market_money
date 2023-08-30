class Api::V0::MarketsSearchController < ApplicationController
  before_action :invalid_params, only: [:index]

  def index
    @markets = MarketSearchFacade.search_markets(params[:name], params[:city], params[:state])
    render json: MarketSerializer.new(@markets)
  end

  private

  def invalid_params
    return error if city_and_name || just_city
  end

  def city_and_name  # << invlaid params
    params[:city].present? && params[:name].present? && params[:state].blank?
  end

  def just_city # << invlaid params
    params[:city].present? && params[:name].blank? && params[:state].blank?
  end

  def error
    render json: { errors: [{ detail: "Invalid set of parameters. Please provide a valid set of parameters to perform a search with this endpoint."}] }, status: 422
  end
end