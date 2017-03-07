class Trip

  def initialize trip_id, driver_id, rider_id, date, rating
    @id = trip_id
    @driver_id = driver_id
    @rider_id = rider_id
    @date = date
    @rating = rating
  end

  def self.all
    #reads trips.csv and puts info into array of Trip instances
  end

  def self.find_trips_by_rider
    #call all
    #search by rider_id to return array of Trip instances associated with that rider
  end

  def self.find_trips_by_driver
    #call all
    #search by driver to return array of Trip instances associated with that driver
  end

  def driver
    #call Driver.find to return Driver instance associated with the driver_id of the trip instance
  end

  def rider
    #call Rider.find to return Rider instance associated with the rider_id of the trip instance
  end

end
