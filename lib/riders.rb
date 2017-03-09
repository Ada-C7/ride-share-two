
module RideShare

  class Rider
    attr_reader :id, :name, :phone_num

    def initialize(id, name, phone_num)
      @id = id
      @name = name
      @phone_num = phone_num
    end


    def self.all
      riders_array = []
      CSV.read("support/riders.csv", {:headers => true}).each do |rider|
        begin
          riders_array << (Rider.new(rider[0], rider[1], rider[2]))
        rescue ArgumentError
          riders_array << (Rider.new(rider[0], rider[1], nil))
          puts "Invalid phone number for rider #{id}"
        end
      end
      riders_array
    end

    def self.find(id)
      rider_array = self.all
      rider_array.each do |rider|
        if id == rider.id
          return rider
        end
      end
      raise ArgumentError.new "Rider #{id} does not exist"
    end

    def trips
      rider_id = id
      RideShare::Trip.find_by_rider(rider_id)
      #retrieve the list of trip instances
      #that only this rider has taken
    end

    def drivers
      rider_trips = trips
      drivers_array = []
      rider_trips.each do |trip|
        drivers_array << trip.find_driver
      end
      # return @drivers_array
      return drivers_array.uniq { |driver| driver.id }
      #retrieve the list of all
      #previous driver instances
      #(through the trips functionality built above)
    end
  end
end
