require 'csv'

class Driver

  attr_reader :id, :name, :vehicle_id

  def initialize(hash)
    @id = hash[:id]
    @name = hash[:name]
    @vehicle_id = hash[:vehicle_id]
  end

  def get_trips
    #
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

  def self.all(csv)
    my_file = CSV.open(csv)

    all_driver_info = []
    my_file.each do |line|
      driver_hash = {}
      driver_hash[:id] = line[0].to_i
      driver_hash[:name] = line[1]
      driver_hash[:vehicle_id] = line[2] if line[2].length == 17
      # add arg error raise
      all_driver_info << driver_hash
    end
    raise NoDataError.new("no data") if all_driver_info.empty?
    all_drivers = []
    all_driver_info.delete_at(0)
    all_driver_info.each do |driver|
      new_driver = Driver.new(driver)
      all_drivers << new_driver
    end

    return all_drivers
  end

  def self.find(look_for_id)
    all_drivers = Driver.all("support/drivers.csv")
    found_driver = nil
    all_drivers.each do |driver|
      found_driver = driver if driver.id == look_for_id
    end
    raise ArgumentError.new("No driver found") if found_driver == nil
    return found_driver
  end

end
