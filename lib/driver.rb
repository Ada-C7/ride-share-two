require 'csv'

module RideShare
  class Driver
    attr_reader :driver_id, :name, :vin

    def initialize(driver_info)
      @driver_id = driver_info[:driver_id]
      @name = driver_info[:name]
      raise ArgumentError.new("A valid vin is 17 characters long") if driver_info[:vin].length < 17
      @vin = driver_info[:vin]
    end

    def self.create_all_drivers


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

  end
end


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
