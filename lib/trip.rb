require 'csv'

class Trip
  attr_reader :id, :driver_id, :rider_id, :date, :rating

  @@all_trips = nil

  def initialize(id, driver_id, rider_id, date, rating)
    @id = id
    @driver_id = driver_id
    @rider_id = rider_id
    @date = date

    unless (rating.is_a? Integer) && (1..5).include?(rating)
      raise ArgumentError.new("rating must be an integer within range 1-5")
    else
      @rating = rating
    end
  end

  def self.all
    return @@all_trips if @@all_trips
    trips = CSV.read("support/trips.csv", { :headers => true })

    @@all_trips = trips.map do |line|
      Trip.new(line[0].to_i, line[1].to_i, line[2].to_i, line[3], line[4].to_i)
    end

    return @@all_trips
  end

  def self.find_trips_driver(driver_id)
    Trip.all.select { |trip| trip.driver_id == driver_id }
  end

  def self.find_trips_rider(rider_id)
    Trip.all.select { |trip| trip.rider_id == rider_id }
  end

  def driver
    Driver.find(@driver_id)
  end

  def rider
    Rider.find(@rider_id)
  end

end
