module RideShare
  class Rider
    attr_reader :name, :id, :phone_num

    def initialize(args)
      @name = args[:name]
      @id = args[:id]
      @phone_num = args[:phone_num]
    end

    # retrieves the list of trip instances that only this rider has taken
    def trips
    end

    # retrieves the list of all previous driver instances
    def drivers
    end

    # retrieves all riders from the CSV file
    def self.all
    end

    # finds a specific rider using their numeric ID
    def self.find(rider_id)
    end
  end
end
