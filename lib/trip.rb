require_relative 'rideshare'

  class Trip

    # reader: ID, driver_ID, rider_ID, date, rating

    # initialize
    # each trip should have @ID, @rider_ID, @driver_ID, @date, @rating
    # rating must be within 1-5, else InvalidRatingError

    # self.all
    # returns array of all instances of trip

    # self.find_drivers(rider_ID)
    # returns array of all instances of trip with rider_ID

    # self.find_riders(driver_ID)
    # returns array of all instances of trip with driver_ID

  end
