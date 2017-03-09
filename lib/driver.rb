require 'csv'

# DAN_CONSTANT = 106
module RideShare
  class Driver
    attr_reader :driver_id, :name, :vin

    # def initialize(driver_info)
    #
    # end



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


  end
end
