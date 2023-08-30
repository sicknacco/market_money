class AtmFacade
  def initialize(market)
    @market = market
  end

  def atms_near_market
    lat = @market.lat
    lon = @market.lon
    atms = AtmService.get_atms(lat, lon)
    atms.map do |atm|
      Atm.new(atm)
    end
  end
end