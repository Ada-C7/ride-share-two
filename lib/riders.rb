require 'csv'

module RideShare
  class Rider
    attr_reader :id, :name, :phone_num

    def initialize(rider_details)
      @id = rider_details[:id]
      @name = rider_details[:name]
      @phone_num = rider_details[:phone_num]
      ## TW: Would I not need to initialize since I'm not validating anything?
    end

    def self.readCSV
      @@riders = []
      if @@riders.empty?
        CSV.foreach("support/riders.csv", {:headers => true}) do |line|
          @@riders << self.new({id: line[0].to_i, name: line[1].to_s, phone_num: line[2].to_s})
        end
      end
      @@riders
    end

    def self.getAll
      readCSV
    end

    def self.find(id)
      rider_details = nil
      getAll.each do |rider|
        if rider.id == id
          rider_details = rider
        end
      end
      rider_details
    end

    def findTrips
      Trip.getTripsByRider(id)
    end
  end
end
