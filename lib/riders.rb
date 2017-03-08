
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
        riders_array << (Rider.new(rider[0], rider[1], rider[2]))
      end
      riders_array
    end

    def self.find(id)  #Should we rescue this??
      rider_array = RideShare::Rider.all
      rider_array.each do |rider|
        if id == rider.id
          return rider
        end
      end
      #raise error??
    end

    def trips
      rider_id = id
      RideShare::Trip.find_by_rider(rider_id)
      #retrieve the list of trip instances
      #that only this rider has taken
    end

    def drivers
      rider_trips = trips
      @drivers_array = []
      rider_trips.each do |trip|
        @drivers_array << trip.find_driver
      end
      return @drivers_array
      #retrieve the list of all
      #previous driver instances
      #(through the trips functionality built above)
    end
  end
end
