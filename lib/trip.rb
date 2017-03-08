# require_relative 'driver'
# require_relative 'rider'
require 'csv'
require 'date'

module RideShare
  class Trip
    attr_reader :trip_id, :rider_id, :driver_id, :date, :rating, :cost, :duration
    def initialize(hash)
      validate_input(hash)
      @trip_id = hash[:trip_id]
      @rider_id = hash[:rider_id]
      @driver_id = hash[:driver_id]
      @date = Date.strptime(hash[:date], "%Y-%m-%d")
      @rating = hash[:rating]
      @cost = hash[:cost]
      @duration = hash[:duration]
    end

    def validate_input(hash)
      raise ArgumentError.new("Parameter must be hash only") if hash.class != Hash
      raise ArgumentError.new("Raiting should be 1 - 5 only") if !((1..5).include? hash[:rating])
      if (hash[:trip_id].class != Integer || hash[:trip_id] <= 0)
        raise ArgumentError.new("Trip id must be positive integer only")
      end
      if hash[:rider_id].class != Integer
        raise ArgumentError.new("Rider id must be integer only")
      end
      if hash[:driver_id].class != Integer
        raise ArgumentError.new("Driver id must be integer only")
      end
      if hash[:date].class  != String
        raise ArgumentError.new("Date must be string only")
      end
    end

    def driver
      #retrieve the associated driver instance through the driver ID
      return RideShare::Driver.find(@driver_id)
    end

    def rider
      #retrieve the associated driver instance through the driver ID
      return RideShare::Rider.find(@rider_id)
    end

    # find all trip instances for a given driver ID:
    def self.all_trips_by_driver(driver_id)
      if driver_id.class != Integer || driver_id <= 0
        raise ArgumentError.new("Driver id must be non-negative integer")
      end
      all_driver_trips = []
      csv = CSV.read("support/trips.csv", 'r')
      csv.each do |line|
        #to avoid putting first line from CSV file that contains column name:
        next if line[0] == "trip_id"
        if driver_id == line[1].to_i
          hash = {trip_id: line[0].to_i, driver_id: line[1].to_i, rider_id: line[2].to_i, date: line[3], rating: line[4].to_i, cost: line[5].to_i, duration: line[6]}
          all_driver_trips << Trip.new(hash)
        end
      end
      all_driver_trips
    end

    # find all trip instances for a given rider ID:
    def self.all_trips_by_rider(rider_id)
      if rider_id.class != Integer || rider_id <= 0
        raise ArgumentError.new("Driver id must be non-negative integer")
      end
      all_rider_trips = []
      csv = CSV.read("support/trips.csv", 'r')
      csv.each do |line|
        #to avoid putting first line from CSV file that contains column name:
        next if line[0] == "trip_id"
        if rider_id == line[2].to_i
          hash = {trip_id: line[0].to_i, driver_id: line[1].to_i, rider_id: line[2].to_i,
            date: line[3], rating: line[4].to_i, cost: line[5].to_i, duration: line[6]}
          all_rider_trips << Trip.new(hash)
        end
      end
      if all_rider_trips.empty?
        puts "Could not find  rider id (#{rider_id}) "
      end
      return all_rider_trips
    end

    def self.all_trips
      all_trips = []
      csv = CSV.read("support/trips.csv", 'r')
      csv.each do |line|
        #to avoid putting first line from CSV file that contains column name:
        next if line[0] == "trip_id"
        hash = {trip_id: line[0].to_i, driver_id: line[1].to_i, rider_id: line[2].to_i, date: line[3], rating: line[4].to_i, cost: line[5].to_i, duration: line[6]}
        all_trips << Trip.new(hash)
      end
      all_trips
    end

    def self.add_cost_duration_to_csv
      array_of_random_prices = ["trip_cost"] # column name
      600.times do
        rand_num = rand(20.00...150.00).round(2)
        array_of_random_prices << rand_num
      end
      array_of_random_durations = ["trip_duration(minutes)"]
        # rand_num = rand(5...200)
        # array_of_random_durations << rand_num
        t1 = Time.new(2017, 01, 02, 0, 0, 0)
        t2 = Time.new(2017, 01, 02, 3, 0, 0)
        600.times do
            rand_time = Time.at(t1.to_f + rand * (t2.to_f - t1.to_f))
            array_of_random_durations << "#{rand_time.hour}:#{rand_time.min}:#{rand_time.sec}"
        end

      helpers_array = CSV.read("support/trips.csv")
      helpers_array.each do |c|
        c << array_of_random_prices.shift
        c << array_of_random_durations.shift
      end
      # rewrite csv file with new columns "trip_cost" and "duration"
      CSV.open('support/trips.csv', 'w') do |csv_object|
        helpers_array.each do |row_array|
          csv_object << row_array
        end
      end
    end # end of method



  end # end of class
end # end of method

# RideShare::Trip.add_cost_duration_to_csv
