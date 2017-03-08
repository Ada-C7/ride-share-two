require 'csv'

class Driver
  attr_reader :id, :name, :vin

  def initialize(id, name, vin)
    @id = id.to_i
    @name = name
    raise ArgumentError.new("VIN must be 17 characters long") if vin.to_s.length != 17
    @vin = vin
  end

  def self.all
    # get info from CSV
    # create new instances of Driver
    # push each new Driver instances into an driver_info
    # return the array

    driver_info = []

    CSV.foreach("/Users/jou-jousun/ada/projects/ride-share-two/support/drivers.csv", {:headers => true}) do |driver|
      driver_info << Driver.new(driver[0].to_i, driver[1].to_s, driver[2].to_s)
    end

    return driver_info
  end

  def self.find(id) #could use Class variable here instead of loading driver array each time
    #.find(id) when you input id, it will return the driver (instance) with that id

    Driver.all.each do |driver|
      if driver.id == id
        return driver
      end
    end
    raise ArgumentError.new "Driver doesn't exist"
  end

  def trips(id)
    #pass in driver id
    #get back a collection of all the trip instances of that driver
    #calls trip(class)'s find_many_for_driver method
    Trip.find_all_for_driver(id)
  end

  def rating(id)
    #pass in driver id
    #gets an average rating for that driver
    #calls Driver(class)'s trip(id) method, which will give all the trips (with ratings for each)
    #sum all the ratings, divide by the number of trips/ratings
    all_trips = Trip.find_all_for_driver(id)
    all_ratings = []
    all_trips.each { |trip| all_ratings << trip.rating }
    average = (all_ratings.reduce(:+))/all_ratings.length.to_f
    return average
  end

end
