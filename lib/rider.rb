require_relative 'trip'

module RideShare

  class Rider
    attr_reader

    # creates riders that have an ID, name, and phone number
    def initialize(id, name, phone)
      @id = id
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
    end

    # finds a specific rider using their numeric ID
    def self.find(id)
    end

  end

end
