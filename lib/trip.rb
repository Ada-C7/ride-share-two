require "csv"

module RideSharing
  class Trip

    attr_reader :id, :driver_id, :rider_id, :date, :rating
    def initialize(id, driver_id, rider_id, date, rating)
      @id = id
      @driver_id = driver_id
      @rider_id = rider_id
      @date = date
      @rating = rating

    end

    def self.all(path = "./support/trips.csv")
      all_trips =[]
      CSV.open(path).each do |line_array|
        begin
          raise ArgumentError.new("Sorry, the rating for trip ##{line_array[0]} is not between 1 and 5. This trip will not be recorded." ) if !(1..5).include? line_array[4].to_i
        rescue ArgumentError => exception
          puts "#{exception.message}"
          next
        end
        all_trips << self.new(line_array[0].to_i, line_array[1].to_i, line_array[2].to_i, line_array[3], line_array[4].to_i)
      end
      return all_trips
    end

  end # End of class Trip
end # End of module RideSharing
