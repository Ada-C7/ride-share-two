module RideShare
  class Rider
    include Validation
    attr_reader :id, :name, :phone

    def initialize(rider_hash)
      @id = validate_int(rider_hash[:id], "Rider ID")
      @name = validate_string(rider_hash[:name], "Name")
      @phone = validate_string(rider_hash[:phone], "Phone Number")
    end

    def self.all
      return CSV.read("support/riders.csv")[1..-1].map do |line|
        new( {
          id: line[0].to_i,
          name: line[1],
          phone: line[2]
        } )
      end
    end

    def self.find(id)
      found_rider = all.find { |rider| rider.id == id }
      raise NoRiderError.new("Rider with that ID does not exist") if found_rider == nil
      return found_rider
    end

    def trips
      return Trip.find_rider_trips(id)
    end

    def drivers
      drivers = trips.map do |trip|
        begin
          Driver.find(trip.driver_id)
        rescue NoDriverError => e
          puts "An error has occurred: #{e.message}"
        end
      end
      drivers.delete(nil)
      return drivers.uniq { |driver| driver.id }
    end
  end
end
