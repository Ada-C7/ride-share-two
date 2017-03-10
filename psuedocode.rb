

#class Driver
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
# Rideshare Module --Namespace to hold all the classes
#
# class Riders
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
#end

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

# end
# end
#

#
#
#
