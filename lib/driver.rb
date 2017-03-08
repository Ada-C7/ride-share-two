require 'csv'

module Rideshare
  class Driver
    attr_reader  :driver_id, :name, :vin

    def initialize(trip_hash)

      @driver_id = trip_hash[:driver_id]
      @vin = trip_hash[:vin]
      @name = trip_hash[:name]

    end

    def self.create_drivers
      hash = {}
      CSV.foreach('support/drivers.csv', {:headers => true, :header_converters=> :symbol}) do |row|
        hash[row[0]] = self.new({driver_id:row[0], name:row[1], vin:row[2]})
      end
      return hash
    end


    def self.find_driver(param)

      CSV.foreach('support/drivers.csv', {:headers=> true, :header_converters => :symbol}) do |row|
        return Driver.new({driver_id:row[0], name:row[1], vin:row[2]}) if row[0] == param.to_s
      end
    end

    # def initialize
    #   attributes are set to default values and ready to be assigned in class methods
    #   @id
    #   @name
    #   @vin
    #   @allarray =
    #   @my_trips---this may be a helper method to dry out  code
    # end
    #
    # self.find(param)
    #   raise error if no number given
    #   raise catchable error if valid id type and driver does not exist
    #   if array.length == 0
    #   Open drivers.csv and instantiates the line for which param == true
    # else
    #   my_rides = collect all instances of trip for this dripver
    #
    # end
    #
    # self.find_all
    #   if array.length == 0
    #     Open drivers.csv and instantiates all driver objects
    #   else
    #     all drivers = collect all driver instances
    #   end
    # end
    #
    # def all_trips(param)
    #   if my_trips.length == 0
    #     Open drivers.csv and instantiates all trips for which drivers == self.driver_id
    #   else
    #     my trips = collect all instances of trip for which driver == self.driver_id
    #   end
    # end
    #
    # def avg_rating
    #   if my_trips.length == 0
    #     Open drivers.csv and instantiates the line for which drivers == self.driver_id
    #   else
    #     my trips =  collect all instances of trip for which driver == self.driver_id
    #   end
    #   my_trips.each
    #   use inject enumberable to average ratings and
    #   return average
    #
  end
end
puts Rideshare::Driver.create_drivers
