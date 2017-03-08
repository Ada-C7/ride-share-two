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
      return match[0]
    end

    def get_trips
      Trip.find_by_rider(id)
    end

    def get_drivers
      driver_ids = get_trips.map {|trip| trip.driver_id }
      # call Driver.find; return array of Driver instances
      driver_ids.map {|id| Driver.find(id)}
    end

  end

end
