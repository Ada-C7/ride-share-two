module Rideshare

  class Rider
    attr_reader :rider_id, :name, :phone_num

    def initialize(trip_hash)

      @rider_id = trip_hash[:rider_id]
      @phone_num = trip_hash[:phone_num]
      @name = trip_hash[:name]

    end

    def self.create_rider
      hash = {}
      CSV.foreach('support/riders.csv', {:headers => true, :header_converters=> :symbol}) do |row|
        hash[row[0]] = Rider.new({rider_id:row[0], name:row[1], phone_num:row[2]})
      end
      return hash
    end


    def self.find_rider(param)
      rider = self.create_rider.select!{|key,value| key == param.to_s}
      return rider.values[0]
    end


    def find_my_trips
       Trip.find_by_rider(self.rider_id)
    end


    def find_my_drivers
       trips = self.find_my_trips
       trips.map!{|value| value.make_driver.name}
    end

  end
end


#
#
#
