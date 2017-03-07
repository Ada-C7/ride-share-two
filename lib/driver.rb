require_relative 'rideshare'

  class Driver

    # readers: ID, name, VIN

    # initialize
    # each driver has @id, @name, @VIN
    # VIN must be correct length, else InvalidVinError

    # self.all
    # returns array of all instances of driver

    # self.find(driver_ID)
    # given driver_ID, returns a driver

    # trips(driver_ID)
    # called on driver object
    # given driver_ID
    # call trip.find_drivers(driver_ID)
    # returns all driver's trips

    # average_rating
    # called on driver object
    # call driver's trips(driver_ID)
    # returns all driver's trips
    # map driver trips into driver ratings array
    # find & return average


  end
