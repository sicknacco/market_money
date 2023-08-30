class MarketSearchFacade
  def self.search_markets(name, city, state)
    Market.where("name ILIKE ? AND city ILIKE ? AND state ILIKE ?", "%#{name}%", "%#{city}%", "%#{state}%")
  end
end