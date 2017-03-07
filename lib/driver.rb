module RideShare

  class Driver
    attr_reader :id, :name, :vin

    def initialize(driver_hash)
      raise InvalidVINError.new("VIN must have 17 characters") if driver_hash[:vin].length != 17

      @id = driver_hash[:id]
      @name = driver_hash[:name]
      @vin = driver_hash[:vin]
    end

    def self.all
      all_drivers = []
      # driver_file = CSV.open(csv_file)
      # driver_file = CSV.open("support/drivers.csv")
      # creates and collects instances of Driver from CSV file
      driver_hash = {}
      # driver_file.each do |line|
      #   driver_hash[:id] = line[0].to_i
      #   driver_hash[:name] = line[1]
      #   driver_hash[:vin] = line[2]
      #
      #   unless driver_hash[:name] == "name" #eliminate header line
      #     begin
      #       all_drivers << Driver.new(driver_hash)
      #     rescue InvalidVINError => e
      #       puts "Encountered an error: #{e.message}"
      #     end
      #   end
      # end
      CSV.foreach("support/drivers.csv", {:headers => true}) do |line|
          driver_hash[:id] = line[0].to_i
          driver_hash[:name] = line[1]
          driver_hash[:vin] = line[2]

          begin
            all_drivers << Driver.new(driver_hash)
          rescue InvalidVINError => e
            puts "Encountered an error: #{e.message}"
          end
      end
      return all_drivers
    end

    def get_trips
      # passes driver id to Trip.find_trips_by_driver
      # returns collection of trips taken by this driver
    end

    def avg_rating
      # calls get_trips
      # calculates average rating across all trips
    end



    def self.find
      # finds a specific instance of Driver based on driver ID
    end
  end

end
