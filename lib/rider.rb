require 'csv'
module RideShare
  class Rider
    attr_accessor :rider_id, :name, :phone_num

    def initialize(rider_id, name, phone_num)
      @rider_id = rider_id
      @name = name
      @phone_num = phone_num
    end

    def trips
      # first run, is returning 9 trips when I expect 2. Driver with same ID ("1") as Rider I'm testing here has 9 trips - is it checking for Driver ID instead of Rider ID?

      # Now testing with Rider IDs that I know drivers won't have and it is turning up 0 trips

      # Gah! I forgot I programmed 'find_many' Trip method to only look for Driver IDs!

      Trip.find_many_riders(@rider_id)
    end

    def self.all
      riders = []
      CSV.open("./support/riders.csv", "r").each do |line|
        riders << self.new(line[0].to_s, line[1].to_s, line[2].to_s)
      end
      return riders
    end

    def self.find(id)
      riders = self.all

      riders.each do |rider|
        if rider.rider_id == id
          return rider
        end
      end
      raise ArgumentError.new("Rider not found")
    end
  end
end
