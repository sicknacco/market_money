class AtmService

  def self.get_atms(lat, lon)
    get_url("/search/2/categorySearch/automatic_teller_machine.json?lat=#{lat}&lon=#{lon}")
  end

  def self.conn
    Faraday.new(url: 'https://api.tomtom.com') do |faraday|
      faraday.params['key'] = ENV['TOMTOM_KEY']
    end
  end

  private

  def self.get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end