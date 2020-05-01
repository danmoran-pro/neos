require 'faraday'
require 'figaro'
require 'pry'
require_relative './nasa_service'
require_relative './asteriod'
# Load ENV vars via Figaro
Figaro.application = Figaro::Application.new(environment: 'production', path: File.expand_path('../config/application.yml', __FILE__))
Figaro.load

class NearEarthObjects
  def self.find_neos_by_date(date)
    # conn = Faraday.new(
    #   url: 'https://api.nasa.gov',
    #   params: { start_date: date, api_key: ENV['nasa_api_key']}
    # )
    # asteroids_list_data = conn.get('/neo/rest/v1/feed')

    service = NasaService.new(date)

    parsed_asteroids_data = service.get_asteroid_list

    asteriod_setup = Asteriod.new(parsed_asteroids_data)

    largest_astroid_diameter = asteriod_setup.largest_astroid_diameter
    # largest_astroid_diameter = parsed_asteroids_data.map do |astroid|
    #   astroid[:estimated_diameter][:feet][:estimated_diameter_max].to_i
    # end.max { |a,b| a<=> b}
    
    total_number_of_astroids = asteriod_setup.count_of_data
    # total_number_of_astroids = parsed_asteroids_data.count

    formatted_asteroid_data = asteriod_setup.formatted_asteroid_data
    # formatted_asteroid_data = parsed_asteroids_data.map do |astroid|
    #   {
    #     name: astroid[:name],
    #     diameter: "#{astroid[:estimated_diameter][:feet][:estimated_diameter_max].to_i} ft",
    #     miss_distance: "#{astroid[:close_approach_data][0][:miss_distance][:miles].to_i} miles"
    #   }
    # end

    {
      astroid_list: formatted_asteroid_data,
      biggest_astroid: largest_astroid_diameter,
      total_number_of_astroids: total_number_of_astroids
    }
  end
end
