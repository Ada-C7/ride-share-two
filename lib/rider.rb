  require 'csv'
module Rideshare
  #
  class Rider
    attr_reader :rider_id, :name, :phone_num

    def initialize(trip_hash)

      @rider_id = trip_hash[:rider_id]
      @phone_num = trip_hash[:phone_num]
      @name = trip_hash[:name]

    end

    def self.create_rider
      hash = {}
      CSV.foreach('support/riders.csv', {:headers => true, :header_converters=> :symbol}) do |row|
        hash[row[0]] = Rider.new({rider_id:row[0], name:row[1], phone_num:row[2]})
      end
      return hash
    end


    def self.find_rider(param)

      CSV.foreach('support/riders.csv', {:headers=> true, :header_converters => :symbol}) do |row|
        return row[0] =  Rider.new({rider_id:row[0], name:row[1], phone_num:row[2]}) if row[0] == param.to_s
      end
    end
    # require '..support/riders.csv'
    # require '..support/trips.csv'

    # def initialize
    #   attributes are set to default values and ready to be assigned in class methods
    #   @id
    #   @name
    #   @phone
    #   @my_trips = ""
    #  @allriders
    # end

    # def allriders_created?
    #   allriders.length >0
    # end
    #
    # def create_allriders
    #   allriders << open csv and create instances of each rider
    #    return allriders
    # end

    # def mytrips_created?
    #   my_trips.length >0
    # end
    #
    # def create_my_trips
    #   my_trips << open csv and create instances of each trip
    #    return my_trips
    # end
    #

    # self.find_all_riders
    #    self.create_my_trips unless allriders_created?
    #    returns @allriders
    # end
    #

    # self.find_any_rider(param)
    #    self.create_trips unless allriders_created?
    #   if @alltrips.each |array| do
    #    array[0] == param
    #    rider_id = csv.open rider_id
    #   return rider_id
    #   end
    # end

    # def find_my_trips
    #    self.create_my_trips unless mytrips_created?
    #    return @mytrips
    # end

    # find_my_drivers()
    # create my_drivers = []
    #   raise error if no number given
    #   raise catchable error if valid id type and driver does not exist
    #   self.create_my_trips unless trips_created?
    #     find all trip instances with find_rider_trips class method on Trips Class
    #   trip_instances = call Rideshare::Trips.find_rider_trips(@id)
    #     iterate through trip istances and save driver_ids
    #   trip_instances.each do |trip_instances|
    #     my_drivers << driver_id
    #   end
    #     my_drivers.each do |id| csv.open(id)
    # end
    #
    #end
end
end
#

#
#
#
