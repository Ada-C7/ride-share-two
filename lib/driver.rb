require 'csv'
# http://alvinalexander.com/blog/post/ruby/ruby-nameerror-uninitialized-constant-error-message
# I was getting "NameError: uninitialized constant" b/c need to require trip.rb file
require_relative 'trip'

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
      CSV.read(
      "support/drivers.csv",
      headers: true,
      header_converters: :symbol,
      converters: :all
      ).map { |line| line.to_h }
    end

    def self.find(driver_id)
      # find a specific driver using their numeric ID
      id_find = self.create_all_drivers
      id_find.each do |i|
        if i[:driver_id] == driver_id
          return i
        end
      end
    end

    def trips
      # *Given a driver object*
      # retrieve the list of trip instances that only this driver has taken
      return RideShare::Trip.driver_trips(@driver_id)
      # right now, giving it the array of hashes.
      # works when it's one .new object, so I said array[0]
      # but then it complains can't .trips on a hashes
      # hash != class object
      # I'd like to try something like this: http://pullmonkey.com/2008/01/06/convert-a-ruby-hash-into-a-class-object/
    end

  end
end


#it's ok for something to return nil, don't necessarily need an Error/Exception


################## FAILED CODE ########################

# SOMETHING HERE ISN'T WORKING!!
# def trips(driver_id)
#   # Given a driver object, you should be able to:
#   # retrieve the list of trip instances that only this driver has taken
#   @all_trips = RideShare::Trip.find_all_driver_trips(driver_id)
#   return @all_trips
# end
#
# def trip_average
#   # self.trips(driver_id)
#   # retrieve an average rating for that driver based on all trips taken
#   # @average = @all_trips[:rating] / @all_trips.length => NO GO. Not doing what I think
#
#   #http://stackoverflow.com/questions/2238767/retrieving-specific-hash-key-values-from-an-array-of-hashes
#   #array_of_hashes.map { |hash_from_array| hash_from_array[:key] }
#   array_of_ratings = @all_trips.map { |each_trip| each_trip[:rating] }
#   # add all the ratings together
#   # http://stackoverflow.com/questions/1538789/how-to-sum-array-of-numbers-in-ruby
#   # want 0 for any driver that didn't take any trips and therefore no ratings so empty array
#   average = array_of_ratings.inject(0, :+) / array_of_ratings.length
#   return average
# end


#NOT THE PROPER OUTPUT, figured out how Alix/Sahana's works, going with it
# csv_contents = CSV.read("support/drivers.csv")
# csv_contents.shift
# #http://stackoverflow.com/questions/11740439/how-can-i-skip-the-header-row-when-reading-a-csv-in-ruby
# #http://stackoverflow.com/questions/5347949/whats-different-between-each-and-collect-method-in-ruby
# csv_contents.collect do |single_driver_info|
#   Driver.new(
#   driver_id: single_driver_info[0].to_i,
#   name: single_driver_info[1],
#   vin: single_driver_info[2]
#   )
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
