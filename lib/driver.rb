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



  def self.find(id)

    @@drivers.find do |driver|

      if driver.driver_id == id
        return driver
      end
    end

    raise ArgumentError.new "#{id} returned no results"
  end #end self.find



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
