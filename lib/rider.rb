require "csv"

module RideSharing
  class Rider
    attr_reader :id, :name, :phone_num
    def initialize(id, name, phone_num)
      @id = id
      @name = name
      @phone_num = phone_num
    end

    def self.all(path = "./support/riders.csv")
      all_riders =[]
      CSV.foreach(path, {:headers => true}) do |line_array|
        all_riders << self.new(line_array[0].to_i, line_array[1], line_array[2])
      end
      return all_riders
    end

    def self.find(rider_id)
      found_rider = self.all.select { |rider| rider.id == rider_id}
      raise ArgumentError.new("No such id number exist") if found_rider == []
      return found_rider.first
    end

    def list_of_trips
      RideSharing::Trip.find_all_trips_for_rider(@id)
    end

    def previous_drivers
      drivers = list_of_trips.map { |trip| trip.find_driver}
      drivers = drivers.uniq
      return drivers
    end


  end # End of class Rider
end # End of module RideSharing
