class Driver

  def initialize (driver_id, name, vin) #order matches csv file
    @id = id
    @name = name
    @vin = vin #check that this is of valid length
  end

  def self.all
    #reads in lines from CSV file and process them as new Driver objects
    #check to make sure the entries are valid, if they are not make decisions about how to handle them
  end

  def self.find driver_id
    #calls self.all to create array of Driver instances
    #looks through array to see if one has a driver_id that matches search field
  end

  def trips
    #calls Trip.file_trips_by_driver (will pass driver.id)
    #returns array of trips that this driver has completed
  end

  def rating
    #calls trips
    #returns average rating of those trips
  end


end
