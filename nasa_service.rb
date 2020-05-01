class NasaService 

  attr_reader :date

  def initialize(date)
    @date = date  
  end 

  def conn
    conn = Faraday.new(
      url: 'https://api.nasa.gov',
      params: { start_date: @date, api_key: ENV['nasa_api_key']}
    )
  end 
  
  def get_asteroid_list
   asteroids_list_data = conn.get('/neo/rest/v1/feed')

   JSON.parse(asteroids_list_data.body, symbolize_names: true)[:near_earth_objects][:"#{date}"]
  end 
end 