module RideShare
  class Driver

    @@drivers = nil

    attr_reader :driver_id, :name, :vin

    def initialize(driver_hash)
      @driver_id = driver_hash[:driver_id]
      @name = driver_hash[:name]
      @vin = driver_hash[:vin]
      # vin number should be a specific length to ensure it is a valid vehicle identification number <-method?
    end


    def trips_taken
      trips = RideShare::Trip.find(@driver_id)
      return trips
    end


  #def average_rating
  #average_rating = ratings.all / ratings.length
  #return average_rating
  #end

  #self.find(id)
  #find id in @@drivers
  #returns a single driver associated with that id
  #end


      # self.all
      # # reads csv file
      #
      # # creates new dirvers instances
      # # returns array/hash of all drivers
      # # @@drivers <<
      # end



    def self.all

      if @@drivers == nil

        @@drivers = []

        CSV.read("support/drivers.csv").each do |row|
          driver = {
            driver_id: row[0].to_i,
            name: row[1],
            vin: row[2]
          }

          @@drivers << RideShare::Driver.new(driver)

        end
      end
      return @@drivers
    end #

  end #end of class
end #end of module
