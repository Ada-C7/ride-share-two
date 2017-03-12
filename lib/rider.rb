require 'csv'
module RideShare
  class Rider
    attr_accessor :rider_id, :name, :phone_num

    def initialize(rider_id, name, phone_num)
      @rider_id = rider_id
      @name = name
      @phone_num = phone_num
    end

    def self.all
      riders = []
      CSV.open("./support/riders.csv", "r").each do |line|
        riders << self.new(line[0], line[1], line[2])
      end
      return riders
    end

  end
end
