
require "csv"
module Ride_Share
class Rider

  attr_reader :id, :name, :phone_number

  def initialize(args_hash)
    #csv header: rider_id,name,phone_num
    @id = args_hash[:rider_id]
    @name = args_hash[:name]
    @phone_number = args_hash[:phone_num]

  end

  def self.all
    all_riders_array = []
    CSV.read("support/riders.csv", {:headers => true, :header_converters => :symbol}).each do |line|
      all_riders_array << Ride_Share::Rider.new(line)
    end
    return all_riders_array
  end

  def self.find(rider_id)
    rider = all.detect {|rider| (rider.id == rider_id) }
    (rider != nil) ? (return rider) : (raise ArgumentError.new "invalid rider id")
  end

  def self.print_all
    all.each do |rider|
      puts "rider id: #{rider.id}, name: #{rider.name}, phone: #{rider.phone_number}"
    end
  end

  def retrieve_trips
    #retrieve the list of trip instances for a rider
    Ride_Share::Trip.find_rider_trips(@id)
  end

  def retrieve_drivers
    #retrieve the list of all previous driver instances for a rider
    #returns list of driver instances
    retrieve_trips.map {|trip| Ride_Share::Driver.find(trip.driver_id)}.uniq
  end

end # class
end # module

# Rider.print_all
