require 'csv'

module RideShare
  class Driver
    attr_reader :driver_id, :name, :vin

    def initialize(driver_info)
      # have an ID, name and vehicle identification number
      @driver_id = driver_info[:driver_id]
      @name = driver_info[:name]

      # Each vehicle identification number should be a specific length to ensure it is a valid vehicle identification number
      raise ArgumentError.new("A valid vin is 17 characters long") if driver_info[:vin].length < 17

      @vin = driver_info[:vin]
    end

    def self.create_all_drivers
      # retrieve all drivers from the CSV file
      csv_contents = CSV.read("support/drivers.csv")
      csv_contents.shift
      #http://stackoverflow.com/questions/11740439/how-can-i-skip-the-header-row-when-reading-a-csv-in-ruby
      #http://stackoverflow.com/questions/5347949/whats-different-between-each-and-collect-method-in-ruby
      csv_contents.collect do |single_driver_info|
        Driver.new(
        driver_id: single_driver_info[0].to_i,
        name: single_driver_info[1],
        vin: single_driver_info[2]
        )
      end
    end

    def self.find(driver_id)
      # find a specific driver using their numeric ID
      self.create_all_drivers[driver_id-1]
    end

    def trips
    # Given a driver object, you should be able to:
      # retrieve the list of trip instances that only this driver has taken
      @all_trips = RideShare::Trip.find_all_driver_trips(driver_id)


      # retrieve an average rating for that driver based on all trips taken
      @average = @all_trips[:rating] / @all_trips.length

    end

  end
end



# Alix's version, kinda like Sahana. Makes more sense than what I was trying in Failed code
# CSV.read(
# filename,
# headers: true,
# header_converters: :symbol,
# converters: :all
# ).map { |line| line.to_h }

################## FAILED CODE ########################
# Trying to hard to make this an array of hashes. Just do what works for now
# def initialize(driver_info)
#   @driver_id = driver_info[:driver_id]
#   @name = driver_info[:name]
#   # raise ArgumentError.new("Invalid VIN. VIN's are 17 characters long") if @vin.length < 17
#   @vin = driver_info[:vin]
# end
#
# def self.create_all_drivers
#   # http://technicalpickles.com/posts/parsing-csv-with-ruby/
#   # SEEMS LIKE A GREAT idea DOES IT WORK??
#   #http://stackoverflow.com/questions/14199784/convert-csv-file-into-array-of-hashes
#
#   # CSV::Converters[:blank_to_nil] = lambda do |field|
#   #   field && field.empty? ? nil : field
#   # end
#   # , header_converters: symbol, converters: [:all, :blank_to_nil]
#
#   all_drivers = []
#   CSV.foreach("support/drivers.csv", headers: true) do |line|
#     all_drivers << RideShare::Driver.new(line)
#   end
#
# end
