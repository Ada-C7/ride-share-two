require 'csv'

class Driver

  attr_reader :id

  def initialize(hash)
    @id = hash[:id]
    @name = hash[:name]
    @vehicle_id = hash[:vehicle_id]
  end

  def get_trips
    trips = Trip.all_with_driver(@id)
    return trips
  end

  def average_rating
    trips = get_trips
    total_ratings = 0
    trips.each do |trip|
      total_ratings += trip.rating
    end
    average = total_ratings / trips.length

    return average
  end

  def self.all
    my_file = CSV.open("support/drivers.csv")
    all_driver_info = []
    my_file.each do |line|
      driver_hash = {}
      driver_hash[:id] = line[0].to_i
      driver_hash[:name] = line[1]

      driver_hash[:vehicle_id] = line[2] if line[2].length == 17

      all_driver_info << driver_hash
    end
    all_drivers = []
    all_driver_info.delete_at(0)
    all_driver_info.each do |driver|
      new_driver = Driver.new(driver)
      all_drivers << new_driver
    end

    return all_drivers
  end

  def self.find(look_for_id)
    all_drivers = Driver.all
    found_driver = nil
    all_drivers.each do |driver|
      found_driver = driver if driver.id == look_for_id
    end
    puts "found driver is #{found_driver}"
    raise ArgumentError.new("No driver found") if found_driver == nil
    return found_driver
  end

end
