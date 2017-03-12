module RideShare

  class Rider
    attr_reader :id, :name, :phone

    def initialize(id, name, phone)
      raise ArgumentError.new("Id must be an integer") if id.class != Integer
      raise ArgumentError.new("Name must be a string") if name.class != String
      raise ArgumentError.new("Phone must be a string") if phone.class != String
      @id = id #.to_i
      @name = name
      @phone = phone
    end

    def trips
      return RideShare::Trip.riders_trips(@id)
    end

    def drivers
      drivers = []

      trips.each do | trip |
        drivers << RideShare::Driver.find(trip.driver_id)
      end

      return drivers
    end

    def self.all
      all_riders = []

      CSV.foreach("support/riders.csv", :headers => true) do | line |
        id = line[0].to_i
        name = line[1]
        phone = line[2]

        all_riders << RideShare::Rider.new(id, name, phone)
      end

      return all_riders
    end

    def self.find(rider_id)
      all_riders = RideShare::Rider.all

      all_riders.each do | rider |
        return rider if rider_id == rider.id
      end

      raise ArgumentError.new("Invalid Rider ID in RideShare:Rider #find")
    end

  end

end
