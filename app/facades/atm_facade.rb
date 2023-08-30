class AtmFacade
  def self.get_atms(market)
    atms = AtmService.get_atms(market.lat, market.lon)
    atms[:results].map do |atm_data|
      Atm.new(atm_data)
    end
  end
end