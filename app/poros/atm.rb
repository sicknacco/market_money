class Atm
  attr_reader :id,
              :name,
              :address,
              :lat,
              :lon,
              :distance

  def initialize(atm_params)
    @id = nil
    @name = atm_params[:name]
    @address = atm_params[:address]
    @lat = atm_params[:lat]
    @lon = atm_params[:lon]
    @distance = atm_params[:distance]
  end
end