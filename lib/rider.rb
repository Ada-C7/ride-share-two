require "csv"

module RideShareTwo
  class Rider

    attr_reader :rider_id, :name, :phone_num

    def initialize(rider_id, name, phone_num)
      @rider_id = rider_id
      @name = name
      @phone_num = phone_num
    end

    def self.all_riders
      all_riders = []
      CSV.open("support/riders.csv",{:headers => true}).each do |array|
        all_riders << self.new(array[0], array[1], array[2].to_s)
      end
      return all_riders
    end



    def self.find_rider(rider_id)
      result = self.all_riders.select { |a| a.rider_id == rider_id }
      return result.first
    end


  end

end
