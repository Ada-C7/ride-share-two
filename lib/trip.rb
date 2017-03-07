class Trip
  #@@trips = {} #or array

  # def initialize(trip_hash)
  #   @id = trip_hash[:id]
  #   @driver_id = trip_hash[:driver_id]
  #   @rider_id = trip_hash[:rider_id]
  #   @date = trip_hash[:date]
  #   @rating = trip_hash[:rating] #(1-5) <-method?
  # end


  #def find_driver
  #driver = Driver::find(@driver_id) #using the self.find method from driver class
  #return driver
  #end

  #def find_rider
  #rider = Rider::find(@rider_id)
  #return rider

  #self.find(driver_id)
  #from @@trips find all trips with associated driver
  #return trips
  #end

  #self.find(rider)
  #from @@trips find all trips with associated rider
  #return trips
  #end

  #self.all
  #reads csv
  #creates new trip instances
  #@@trips << new instances
  #return @@trips
  #end
  
end
