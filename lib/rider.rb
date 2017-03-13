# require 'csv'
# require_relative 'file'
# require_relative 'trip'

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
      raise ArgumentError.new "Phone number less than 7" if phone_number.length < 7
      phone_number
    end

    # this method will check to see if any two or more riders have the same id
    def self.test_data_for_duplicates(riders)
      rider_ids = riders.map { |rider| rider.id }
      if rider_ids.length != rider_ids.uniq.length
        duplicates = rider_ids.detect { |id| rider_ids.count(id) > 1 }
        raise ArgumentError.new("There are two riders with the same id: #{duplicates}")
      end
      riders
    end

    # this method returns the read riders.csv data
    def self.get_data
      file_path = './support/riders.csv'
      ride_data = FileData.new(file_path)
      ride_data.read_csv_and_remove_headings
    end

    # the all method accepts an argument - A FileData object of the read
    # csv riders data. Injecting this object vs reading the csv directly from the method
    # lets me easily test with bad mock data
    # thie method does have a default since the requirments of the this project
    # expect all to me reading the csv - if no argument is passed, nil is set
    # and then get_data is classed which will return the FileData object
    def self.all(rides_data = nil)
      rides_data = get_data if rides_data.nil?
      raise ArgumentError if rides_data.empty?

      riders = rides_data.map do |rider_info|
        # could add messge for arg error below
        raise ArgumentError unless rider_info.length == 3
        rider = Hash.new
        rider[:id] = test_for_integer(rider_info[0])
        rider[:name] = test_name(rider_info[1])
        rider[:phone_number] = test_phone_number(rider_info[2])
        self.new(rider)
      end

      test_data_for_duplicates(riders)
      return riders
    end

    def self.find(rider_id)
      riders = all
      riders.each { |info| return info if info.id == rider_id }
      nil
    end
  end
end
