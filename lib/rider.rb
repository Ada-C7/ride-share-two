require 'csv'

module RideShare
  class Rider
    attr_reader :rider_id, :name, :phone

    def initialize(riders)

      @rider_id = riders[:rider_id]
      @name = riders[:name]
      @phone = riders[:phone]
    end

    def self.all
      @all_riders = []

      CSV.foreach("./support/riders.csv", {:headers => true}) do |line|
        @all_riders << self.new({rider_id:line[0].to_i, name:line[1].to_s, phone:line[2].to_s})
      end
      return @all_riders
    end

    def self.find(rider_id)
      riders = RideShare::Rider.all

      riders.each do |rider|
        if rider.rider_id == rider_id
          return rider
        end
      end
    end

    def get_trips
      return RideShare::Trips.get_trips_rider_id(@rider_id)
    end
  end # end of Driver
end # end of module
