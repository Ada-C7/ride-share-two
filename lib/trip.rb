require "csv"

module RideSharing
  class Trip

    attr_reader :id, :driver_id, :rider_id, :date, :rating
    def initialize(trip_hash)
      raise ArgumentError.new("The input for :id must be an integer > 0.\nThis trip will not be recorded.") if  trip_hash[:trip_id].class != Integer || trip_hash[:trip_id] < 1
      raise ArgumentError.new("The input for :driver_id must be an integer > 0.\nThis trip will not be recorded.") if  trip_hash[:driver_id].class != Integer || trip_hash[:driver_id] < 0
      raise ArgumentError.new("The input for :rider_id must be an integer > 0.\nThis trip will not be recorded.") if  trip_hash[:rider_id].class != Integer || trip_hash[:rider_id] < 0
      raise ArgumentError.new("The input for :date must be a string of format yyyy-mm-dd.\nThis driver will not be recorded.") if  trip_hash[:date].class != String || !(/^(19|20)\d\d-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[01])$/ === trip_hash[:date])
      raise ArgumentError.new("The input for :rating must be an integer between 1 and 5.\nThis driver will not be recorded." ) if trip_hash[:rating].class != Integer || !(1..5).include?(trip_hash[:rating].to_i)



      @id = trip_hash[:trip_id]
      @driver_id = trip_hash[:driver_id].to_i
      @rider_id = trip_hash[:rider_id].to_i
      @date = trip_hash[:date]
      @rating = trip_hash[:rating]
    end
    # def initialize(id, driver_id, rider_id, date, rating)
    #   @id = id
    #   @driver_id = driver_id
    #   @rider_id = rider_id
    #   @date = date
    #   @rating = rating
    # end


    def self.all(path = "./support/trips.csv")
      all_trips = []
      CSV.foreach(path, :headers => true, :header_converters => :symbol) do |row|
        begin
          raise ArgumentError.new("The trip_id \"#{row[0]}\" creates an invalid id number. The id number must be an integer > 0.\nHence this trip will not be recorded." ) if row[0] == nil || row[0].to_i < 1
        rescue ArgumentError => exception
          puts "#{exception.message}"
          next
        end

        begin
          raise ArgumentError.new("The driver_id \"#{row[1]}\" creates an invalid id number. The id number must be an integer >= 0.\nHence this trip will not be recorded." ) if row[1] == nil || row[1].to_i < 0
        rescue ArgumentError => exception
          puts "#{exception.message}"
          next
        end

        begin
          raise ArgumentError.new("The rider_id \"#{row[2]}\" creates an invalid id number. The id number must be an integer >= 0.\nHence this trip will not be recorded." ) if row[2] == nil || row[2].to_i < 0
        rescue ArgumentError => exception
          puts "#{exception.message}"
          next
        end

        begin
          raise ArgumentError.new("The input date for trip_id ##{row[0]} is invalid. It must be a string with format yyyy-mm-dd.\nHence this trip will not be recorded." ) if row[3] == nil ||  !(/^(19|20)\d\d-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[01])$/ === row[3])
        rescue ArgumentError => exception
          puts "#{exception.message}"
          next
        end


        begin
          raise ArgumentError.new("The rating for trip ##{row[0]} is invalid. It must be an integer between 1 and 5. This trip will not be recorded." ) if row[4] == nil || !(1..5).include?(row[4].to_i)
        rescue ArgumentError => exception
          puts "#{exception.message}"
          next
        end

        trip_hash = row.to_hash
        trip_hash[:trip_id] = trip_hash[:trip_id].to_i
        trip_hash[:driver_id] = trip_hash[:driver_id].to_i
        trip_hash[:rider_id] = trip_hash[:rider_id].to_i
        trip_hash[:rating] = trip_hash[:rating].to_i
        all_trips << self.new(trip_hash)
      end
      return all_trips




      # all_trips =[]
      # CSV.foreach(path, {:headers => true}) do |line_array|
      # # CSV.open(path).each do |line_array|
      #   begin
      #     raise ArgumentError.new("Sorry, the rating for trip ##{line_array[0]} is not between 1 and 5. This trip will not be recorded." ) if !(1..5).include? line_array[4].to_i
      #   rescue ArgumentError => exception
      #     puts "#{exception.message}"
      #     next
      #   end
      #   all_trips << self.new(line_array[0].to_i, line_array[1].to_i, line_array[2].to_i, line_array[3], line_array[4].to_i)
      # end
      # return all_trips
    end

    def self.find(trip_id)
      found_trip = self.all.select { |trip| trip.id == trip_id}
      begin
        raise ArgumentError.new("Id number #{trip_id} does not exist") if found_trip == []
      rescue ArgumentError => exception
        puts "#{exception.message}"
      end
      return found_trip.first
    end

    def self.find_all_trips_for_driver(driv_id)
      all_trips_for_driver = self.all.select { |trip| trip.driver_id == driv_id}
      return all_trips_for_driver
    end

    def self.find_all_trips_for_rider(ride_id)
      all_trips_for_rider = self.all.select { |trip| trip.rider_id == ride_id}
      return all_trips_for_rider
    end

    def find_driver
      RideSharing::Driver.find(@driver_id)
    end

    def find_rider
      RideSharing::Rider.find(@rider_id)
    end

  end # End of class Trip
end # End of module RideSharing
