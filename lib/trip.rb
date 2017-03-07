require "csv"
class Ride_Share::Trip

  attr_reader :id, :driver_id, :rider_id, :date, :rating

  def initialize(args_hash)
    #csv header: trip_id,driver_id,rider_id,date,rating
    @id = args_hash[:trip_id]
    @driver_id = args_hash[:driver_id]
    @rider_id = args_hash[:rider_id]
    @date = args_hash[:date]
    @rating = args_hash[:rating]

  end

  def self.all
    all_trips_array = []
    #CSV.read("support/trips.csv", {:headers => true}).each do |line|
    CSV.read("support/trips.csv", {:headers => true, :header_converters => :symbol}).each do |line|

      # id = line[0].to_i
      # d_id = line[1].to_i #driver id
      # r_id = line[2].to_i # trip id
      # date = line[3]
      # rating = line[4].to_i
      all_trips_array << Trip.new(line)
      # all_tripss_array << Trips.new(id: id, driver_id: d_id, rider_id: r_id, date: date, rating: rating)
    end
    return all_trips_array
  end

  def self.print_all
    all.each do |trip|
      puts "trip id: #{trip.id}, date: #{trip.date}, rating: #{trip.rating}"
    end
  end

  def find_driver_trips(driver_id)
    driver_trips = []
    all.each do |trip|
      driver_trips << trip if trip.driver_id == driver_id
    end
    return driver_trips
  end

end

# Trip.print_all
