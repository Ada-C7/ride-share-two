module Carmunity
  class Driver

    #@@drivers = []

    attr_reader :driver_id, :name, :vin

    def initialize(driver_hash)
      @driver_id = driver_hash[:driver_id]
      @name = driver_hash[:name]
      @vin = driver_hash[:vin]
      # vin number should be a specific length to ensure it is a valid vehicle identification number <-method?
    end


    # def trips_taken
    #   trips = Carmunity::Trip.find(@driver_id)
    #   return trips
    # end


  #def average_rating
  #average_rating = ratings.all / ratings.length
  #return average_rating
  #end



  def self.find(id)

    #@@drivers.find do |driver|
    all_drivers = self.all

    all_drivers.find do |driver|

      if driver.driver_id == id
        return driver
      end
    end

    raise ArgumentError.new "#{id} returned no results"
  end #end self.find



    def self.all

      #if @@drivers.length == 0
      drivers = []

        CSV.read("support/drivers.csv").each do |row|
          driver = {
            driver_id: row[0].to_i,
            name: row[1],
            vin: row[2]
          }

          drivers << Carmunity::Driver.new(driver)
          #@@drivers << Carmunity::Driver.new(driver)

        end
      #end
      return drivers#@@drivers
    end #

  end #end of class
end #end of module
