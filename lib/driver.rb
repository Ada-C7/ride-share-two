

module Carmmunity
  class Driver

    attr_reader :driver_id, :name, :vin

    def initialize(driver_hash)
      @driver_id = driver_hash[:driver_id]
      @name = driver_hash[:name]
      @vin = driver_hash[:vin]
      # vin number should be a specific length to ensure it is a valid vehicle identification number <-method?
      raise InvalidVinNumber.new("The vin number is invalid") if @vin.length != 17
    end


    def trips_taken
      trips = Trip.driver_trips(@driver_id)
      return trips
    end


  def average_rating

    rating_sum = 0

    trips_taken.map do |trip|
      rating_sum += trip.rating
    end

    rating_average = rating_sum / trips_taken.length

    return rating_average
  end


  def self.find(id)

    self.all.select do |driver|

      if driver.driver_id == id
        return driver
      end
    end

    raise NoResults.new "#{id} returned no results"
  end #end self.find



  def self.all

    @@drivers = []

    if @@drivers.length < 1


      CSV.read("support/drivers.csv").each do |row|
        driver = {
          driver_id: row[0].to_i,
          name: row[1],
          vin: row[2]
        }

        @@drivers << Driver.new(driver)
      end
      return @@drivers
    else
    end
    return @@drivers
  end #

  end #end of class
end #end of module
