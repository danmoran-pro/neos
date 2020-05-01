class Asteriod

  attr_reader :parsed_asteroids_data

  def initialize(parsed_asteroids_data)
    @parsed_asteroids_data = parsed_asteroids_data  
  end 


  def largest_astroid_diameter
    @parsed_asteroids_data.map do |astroid|
      astroid[:estimated_diameter][:feet][:estimated_diameter_max].to_i
    end.max { |a,b| a<=> b}
  end 

  def formatted_asteroid_data
    @parsed_asteroids_data.map do |astroid|
      {
        name: astroid[:name],
        diameter: "#{astroid[:estimated_diameter][:feet][:estimated_diameter_max].to_i} ft",
        miss_distance: "#{astroid[:close_approach_data][0][:miss_distance][:miles].to_i} miles"
      }
    end
  end

  def count_of_data 
    parsed_asteroids_data.count
  end 
  
end 