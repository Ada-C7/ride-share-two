require 'csv'

module RideShare

  class Rider
    attr_reader :id, :name, :phone_num

    def initialize(id, name, phone_num)
      @id = id.to_i
      @name = name
      @phone_num = phone_num
    end
    def self.all
      rider_array = []
      CSV.open('support/riders.csv', 'r', :headers => true).each do |line|
        id = line["rider_id"].to_i
        name = line["name"].to_s
        phone_num = line["phone_num"].to_s
        rider_array << self.new(id, name, phone_num)
      end
      return rider_array
    end

    def self.find(id)
      Rider.all.each do |file|
        if file.id == id
          return file
        end
      end
      raise ArgumentError.new("This account does not exist")
    end

    #Creates method that uses a method from trip object to retrieve list of trips
    def retrieve_trips
      rider = RideShare::Trip.by_rider(id)
      return rider
    end
    #Each rider should have an ID, name, and phone number
    #Should be able to retrieve the list of trip instances that only this specific rider has taken
    #Retrieve list of all previous driver instances
    #Uses the all method in find method

    #Create method that uses internal trips method to retrieve associated
    # drivers
    def find_drivers

      retrieve_trips.map do |trip|
        RideShare::Driver.find(trip.driver_id)
      end

      # retrieve_trips.map! do |trip|
      #   drivers[trip.driver_id] = 1
      #   drivers.each do |id, value|
      #     drivers[id] = RideShare::Driver.find(id)
      #   end
      # end
      # return drivers.values
    end

  end
end
