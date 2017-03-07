require 'csv'
module RideShare
  class Rider
    attr_reader :rider_id, :name, :phone
    def initialize(hash)
      raise ArgumentError.new("Parameter must be hash only") if hash.class != Hash
      @rider_id = hash[:rider_id]
      @name = hash[:name]
      @phone = hash[:phone]
    end

    def trips
      # RideShare::Trips.all_trips_by_rider
    end

    def drivers #return list of drivers that rider used

    end

    def self.all
      all_riders = []
      csv = CSV.read("support/riders.csv", 'r')
      csv.each do |line|
      #to avoid putting first line from CSV file that contains column name:
        next if line[0] == "rider_id"
        hash = {rider_id: line[0].to_i, name: line[1], phone: line[2]}
        all_riders << Rider.new(hash)
      end
      all_riders
    end

    def self.find(id)
      result = RideShare::Rider.all.select {|rider| rider.rider_id == id}
      if result[0].nil?
        raise ArgumentError.new("Cannot find this ID in riders")
      else
        return result[0]
      end
    end

  end
end

# rider_hash = {rider_id: 32, name: "Natalia", phone:  "1425394958"}
# puts RideShare::Rider.all[299].name
