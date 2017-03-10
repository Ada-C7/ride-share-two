require 'csv'

module RideShare
  class Rider
    attr_reader :rider_id, :name, :phone
    def initialize(rider_id, name, phone)

      @rider_id = rider_id
      @name = name
      @phone = phone
    end


    def self.all
      all_riders = []

      csv_contents = CSV.read("./support/riders.csv")
      csv_contents.shift
      csv_contents.each do |each_rider|
          rider_id = each_rider[0].to_i
          name = each_rider[1].to_s
          phone = each_rider[2].to_s

          rider = RideShare::Rider.new(rider_id, name, phone)
          all_riders << rider
      end
        return all_riders
    end

  end # end of Driver
end # end of module
