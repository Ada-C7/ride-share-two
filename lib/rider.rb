module RideShare
  class Rider
    attr_reader :name, :id, :phone_num

    def initialize(args)
      @name = args[:name]
      @id = args[:id]
      @phone_num = args[:phone_num]
    end

    def trips
    end

    def drivers
    end

    def self.all
    end

    def self.find(rider_id)
    end
  end
end
