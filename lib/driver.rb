module RideShare

  class Driver

    # readers: ID, name, VIN

    # initialize
    # each driver has @id, @name, @VIN
    # VIN must be correct length

    # self.all
    # returns array of all drivers

    # self.find(driver_ID)
    # given driver_ID, returns a driver

    # self.find_many(rider_ID)
    # called from rider class to return array of rider's drivers
    # given driver_ID, returns array of drivers

    # trips(driver_ID)
    # called on driver object
    # given driver_ID
    # call trip.find_many(driver_ID)
    # returns all driver's trips

    # average_rating
    # called on driver object
    # call driver's trips(driver_ID)
    # returns all driver's trips
    # map driver trips into driver ratings array
    # find & return average


  end

end
