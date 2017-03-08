require 'csv'

module RideShare
  class Rider
    attr_reader :id, :name, :phone_number

    def initialize(rider_hash)
      @id = rider_hash[:id]
      @name = rider_hash[:name]
      @phone_number = rider_hash[:phone_number]
    end

    def self.all
      riders = []

      CSV.read("support/riders.csv").each do |rider_row|
        all_riders = RideShare::Rider.new(
        id: rider_row[0].to_i,
        name: rider_row[1],
        phone_number: rider_row[2]
        )
        riders << all_riders
      end
      riders
    end

    def self.find(id)
      save_rider = nil

      find_riders = RideShare::Rider.all
      find_riders.each do |rider|
        if rider.id == id
          save_rider = rider
        end
      end

      raise ArgumentError.new "Warning: Rider #{id} does not exist." if save_rider == nil

      return save_rider
    end

    def trip
      # retruns list of rider trips
    end

  end
end

# puts "#{RideShare::Rider.all}"
