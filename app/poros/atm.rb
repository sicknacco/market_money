class Atm
  attr_reader :id,
              :name,
              :address,
              :lat,
              :lon,
              :distance

  def initialize(atm_params)
    @id = nil
    @name = 'ATM'
    @address = atm_params[:address][:freeformAddress]
    @lat = atm_params[:position][:lat]
    @lon = atm_params[:position][:lon]
    @distance = atm_params[:dist]
  end
end