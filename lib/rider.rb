require 'csv'
require 'ap'

module RideShare
  class Rider
    attr_reader :name, :id, :phone_number
    def initialize(id, name, phone_number)
      @name = name
      @id = id
      @phone_number = phone_number
    end

    #retrieve all riders from the CSV file
    def self.all
      @riders = []
      CSV.foreach("./support/riders.csv", {:headers => true}).each do |line|
        @riders << self.new(line[0].to_i, line[1].to_s, line[2].to_s)
      end
      return @riders
    end

    #find a specific rider using their numeric ID
    def self.find(id)
      rider_find = Rider.all
      rider_find.each do |rider|
        if rider.id == id
          return rider
        end
      end
      raise ArgumentError.new "Sorry, a rider with an ID:#{id} does not exist"
    end

    #retrieve the list of trip instances that only this rider has taken
    def trip_instances_for_rider
      Trip.find_trips_of_rider(id)
    end

    #retrieve the list of all previous driver instances (through the trips functionality built above)
    def retrieve_list_of_previous_drivers
      array_of_rider_trips = Trip.find_trips_of_rider(id)
      array_of_driver_ids = []
      array_of_rider_trips.each do |item|
        array_of_driver_ids << item.driver_id
      end
      array_of_driver_ids.map do |id|
        Driver.find(id)
      end
    end

    #end of class
  end
  #end of module
end

# puts "creates instance for non-self methods\n\n"
# instance_of_rider = Rider.find(12)

# puts "retrieve the list of trip instances that only this rider has taken"
# ap instance_of_rider.trip_instances_for_rider

# puts "retrieve all riders from the CSV file"
# ap Rider.all

# puts "find a specific rider using their numeric ID"
# ap Rider.find(9)

# puts "retrieve the list of all previous driver instances (through the trips functionality built above)"
# ap instance_of_rider.retrieve_list_of_previous_drivers
