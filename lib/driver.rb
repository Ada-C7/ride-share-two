class Driver

  attr_reader :id

  def initialize(hash)
    @id = hash[:id]
    @name = hash[:name]
    @vehicle_id = hash[:vehicle_id]
    # has a valid length to check for
  end

  def get_trips
    # calls Trip.all_with_driver and passes in Driver id
    trips = Trip.all_with_driver(@id)
    return trips
  end

  def average_rating
    # average rating for driver based on all trips taken
    # calls get_trips, adds the rating and divides by how many
    trips = get_trips
    total_ratings = 0
    trips.each do |trip|
      total_ratings += trip.rating
    end
    average = total_ratings / trips.length

    return average
  end

  def self.all
    # read in csv file to create master list of all drivers
    my_file = CSV.open("support/drivers.csv")
    all_driver_info = []
    my_file.each do |line|
      driver_hash = {}
      driver_hash[:id] = line[0].to_i
      driver_hash[:name] = line[1]
      driver_hash[:vehicle_id] = line[2]

      all_driver_info << driver_hash
    end
    all_drivers = []
    all_driver_info.each do |driver|
      new_driver = Driver.new(driver)
      all_drivers << new_driver
    end

    return all_drivers
  end

  def self.find(id)
    # locates a driver in the all list given a driver id
    all_drivers = Driver.all
    found_driver = nil
    all_drivers.each do |driver|
      found_driver = driver if driver.id == id
    end
    raise ArgumentError.new("No driver found") if found_driver == nil
    return found_driver
  end

end
