module RideShare
  class Rider
    attr_reader :id, :name, :phone_num
    
    def initialize(rider_details)
      @id = rider_details[:id]
      @name = rider_details[:name]
      @phone_num = rider_details[:phone_num]
    end

    def self.read_csv
      @@riders = []
      if @@riders.empty?
        CSV.foreach("support/riders.csv", {:headers => true}) do |line|
          @@riders << self.new({id: line[0].to_i, name: line[1].to_s, phone_num: line[2].to_s})
        end
      end
      @@riders
    end

    # def find_trips #< Trip.find_rider_trips(id)
    #   #given rider_id find a list of trips
    #   #also return the driver instances for each trip
    #   Trip.find_rider_trips(@id)
    #   # super
    # end

    def self.all
      read_csv
    end

    def self.find(id)
      rider_details = nil
      all.each do |rider|
        if rider.id == id
          rider_details = rider
        end
      end
      rider_details
    end

  end
end
