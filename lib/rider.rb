module RideShare

  class Rider
    attr_reader :id, :name, :phone

    def initialize(rider_hash)
      @id = rider_hash[:id]
      @name = rider_hash[:name]
      @phone = rider_hash[:phone]
    end

    def self.all
      all_riders = []
      rider_hash = {}

      CSV.foreach("support/riders.csv", {:headers => true}) do |line|
          rider_hash[:id] = line[0].to_i
          rider_hash[:name] = line[1]
          rider_hash[:phone] = line[2]

          all_riders << Rider.new(rider_hash)
      end
      return all_riders
    end

    def self.find(requested_id)
      # finds a specific instance of Rider based on rider ID
      match = Rider.all.select {|rider| rider.id == requested_id}
      raise ArgumentError.new ("No rider exists with that ID") if match.size == 0
      return match[0]
    end

    def get_trips
      # passes driver id to Trip.find_by_driver
      # returns collection of trips taken by this driver
      Trip.find_by_rider(id)
    end

    def list_drivers
      # calls get_trips
      # returns the list of all previous driver instances

    end

  end

end
