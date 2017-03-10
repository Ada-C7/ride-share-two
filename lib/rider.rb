require 'csv'
module RideShare
  class Rider
    attr_reader :id, :name, :phone_number

    def initialize(info)
      @id = info[:id]
      @name = info[:name]
      @phone_number = info[:phone_number]
    end

    # what should be returned if there are no trips?
    # calling find_by_rider will auto return an empty arrays
    # change the Trip.find_by_rider
    def get_trips
      trips = RideShare::Trip.find_by_rider(@id)
    end

    def get_drivers()
      trips = get_trips
      return nil if trips.nil?
      # map returns array of driver instances - you don't need uniq
      # you wont get duplicate driver instances
      trips.map { |trip| trip.get_driver }
    end

  ######################################################
                    ## Class methods ##
  ######################################################

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
        rider[:name] = test_name(rider_info[1])
        rider[:phone_number] = test_phone_number(rider_info[2])
        self.new(rider)
      end
      return riders
    end

    def self.test_for_integer(num)
      Integer(num)
    end

    def self.test_name(name)
      raise ArgumentError.new "Name length is under 3" if name.length < 3
      name
    end

    def self.test_phone_number(phone_number)
      raise ArgumentError.new "Phone number's length under 7" if phone_number.length < 7
      phone_number
    end

    def self.find(rider_id)
      riders = all
      riders.each { |info| return info if info.id == rider_id }
      nil
    end
  end
end
