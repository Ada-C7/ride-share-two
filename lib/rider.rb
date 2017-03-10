# require 'csv'
require_relative 'file'
require_relative 'trip'

module RideShare
  class Rider
    attr_reader :id, :name, :phone_number

    def initialize(info)
      @id = info[:id]
      @name = info[:name]
      @phone_number = info[:phone_number]
    end

    # what should be returned if there are no trips? Thinking Nil
    # changed the Trip.find_by_rider to return nil if no trips
    def get_trips
      RideShare::Trip.find_by_rider(@id)
    end

    def get_drivers()
      trips = get_trips
      return nil if trips.nil?
      trips.map { |trip| trip.get_driver }.uniq { |driver| driver.id }
    end

                      ###################
                      ## Class methods ##
                      ###################

    def self.test_for_integer(num)
      Integer(num)
    end

    def self.test_name(name)
      raise ArgumentError.new "Name length is under 1" if name.length <= 1
      name
    end

    def self.test_phone_number(phone_number)
      raise ArgumentError.new "Phone num less than 7" if phone_number.length < 7
      phone_number
    end

    # If I use the full path path, it will work no matter if I run program
    # can run from spec file, rakefile, or lib file
    def self.get_data
      file_path = '/Users/Cynthia/Documents/Ada/queues/ruby_exercises/ruby_week5/ride-share-two/support/riders.csv'
      ride_data = FileData.new(file_path)
      ride_data.read_csv_and_remove_headings
    end

    def self.all(rides_data = nil)
      rides_data = get_data if rides_data.nil?
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

    def self.find(rider_id)
      riders = all
      riders.each { |info| return info if info.id == rider_id }
      nil
    end
  end
end

# rider = RideShare::Rider.find(164)
# p rider.get_drivers
