require 'csv'
module RideShare
  class Rider
    attr_reader :id, :name, :phone_number

    def initialize(info)
      @id = info[:id]
      @name = info[:name]
      @phone_number = info[:phone_number]
    end

    def get_trips
      RideShare::Trip.find_by_rider(@id)
    end

    def get_drivers
    end

                    ###################
                    ## Class methods ##
                    ###################

    def self.all(rides_data = nil)
      if rides_data.nil?
        ride_data = FileData.new("./support/riders.csv")
        rides_data = ride_data.read_csv_and_remove_headings
      end

      raise ArgumentError if rides_data.empty?
      riders = rides_data.map do |rider_info|
        raise ArgumentError unless rider_info.length == 3
        rider = Hash.new
        rider[:id] = test_for_integer(rider_info[0])
        rider[:name] = rider_info[1]
        rider[:phone_number] = rider_info[2]
        self.new(rider)
      end
      return riders
    end

    def self.test_for_integer(num)
      Integer(num)
    end

    def self.find(rider_id)
      riders = all
      riders.each { |info| return info if info.id == rider_id }
      nil
    end
  end
end
