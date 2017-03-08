module RideShare
  class Rider
    def initialize(id, name, phone_num)
      @id = id
      @name = name
      @phone_num = phone_num
    end

    def self.read_csv
      # Andrew: with all -- put .nil? to reference
      @@riders = CSV.read("support/riders.csv")[1..-1].map do |array_of_details|
        Rider.new(array_of_details[0].to_i, array_of_details[1].to_s, array_of_details[2].to_s)
      end
      # id: array_of_details[0].to_i,
      # name: array_of_details[1].to_s,
      # phone_num: array_of_details[2].to_s

      # riders = {123: {name: Ting, phone_num: 222 22222}}
        # riders = {123: <Rider Object>, 345: <Rider Object>}
      # RideShare::Rider.new(id=array_of_details[0].to_i, name=...)
    end
    # end

    def find_trips #< Trip.find_rider_trips(id)
      #given rider_id find a list of trips
      #also return the driver instances for each trip
      Trip.find_rider_trips(@id)
      # super
    end

    def self.all
      @@riders ||= read_csv
    end

    def self.find(id)
      #given rider_id, return rider instance
      # super

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
