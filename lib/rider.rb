class Rider
  def initialize (rider_id, name, phone_num)
    @id = rider_id
    @name = name
    @phone = phone_num
  end

  def self.all
    # read riders.csv and put it into an array of Rider instances
    #check to make sure that phone numbers are of valid format/length
  end

  def self.find rider_id
    #run self. all
    #find rider instance by rider_id
  end

  def trips
    #call Trip.find_trips_by_rider
    #returns array of trip instances that this rider has taken
  end

  def drivers
    #call trips
    #look through trips and for each trip instance, use the driver_id associated with the trip (trip.driver_id) to call Driver.find(driver_id)
    #store those Driver class instances in an array that gets returned
  end

end
