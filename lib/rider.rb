module RideShare

  class Rider
    attr_reader :id, :name, :phone

    # creates riders that have an ID, name, and phone number
    def initialize(id, name, phone)
      @id = id.to_i
      @name = name
      @phone = phone
    end


    # retreives list of trips for specific rider
    def trips
    end


    # retreives list of all previous drivers for specific rider
    def drivers
    end


    # retreives all riders from the CSV
    def self.all
      all_riders = []

      CSV.open("support/riders.csv").each do | line |
        id = line[0]
        name = line[1]
        phone = line[2]

        all_riders << RideShare::Rider.new(id, name, phone)
      end

      return all_riders
    end


    # finds a specific rider using their numeric ID
    def self.find(rider_id)
      all_riders = RideShare::Rider.all

      all_riders.each do | rider |
        return rider if rider_id == rider.id
      end

      raise ArgumentError.new("Invalid Rider ID")
    end

  end

end
