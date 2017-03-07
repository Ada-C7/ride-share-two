require 'csv'

class Trip
  attr_reader :id, :driver_id, :rider_id, :date, :rating

  def initialize(id, driver_id, rider_id, date, rating)
    @id = id
    @driver_id = driver_id
    @rider_id = rider_id
    @date = date
    raise ArgumentError.new("Rating must be between 1 - 5") if rating <= 0 || rating > 5 || rating.class != Integer
    @rating = rating
  end

  def driver
    # you have a trip object
    # it has id, driver_id, etc
    # trip.driver
    # takes the driver_id
    # calls Driver class' self.find
    # returns the driver instance

    Driver.find(driver_id)
  end

  def rider(rider_id)
    # self.all
    # input rider_id
    # give back the rider instance for that rider_id, i.e. if array.rider_id == rider_id
    # retrieve the associated rider instance through the rider ID
    Rider.find(rider_id)
  end

  def self.all
    # read in csv file for all trips
    # create an array of trip instances

    @trip_info = []

    all_trip = CSV.open("/Users/jou-jousun/ada/projects/ride-share-two/support/trips.csv")

    all_trip.each do |trip|
      @trip_info << Trip.new(trip[0].to_i, trip[1].to_i, trip[2].to_i, trip[3].to_s, trip[4].to_i)
    end

    @trip_info.shift # the first element is the header of the CSV file

    return @trip_info

  end

  def self.find_all_for_driver
    # find all trip instances for a given driver ID
  end

  def self.find_all_for_rider

  end

end
