require 'csv'

module RideShare
  class Driver
    attr_reader :id, :name, :vin

    #Each Driver should have an ID, name, VIN
    def initialize(id, name, vin)
      @id = id.to_i
      @name = name
      @vin = vin
      #Vin should be a specific length to ensure validity(raise error)
    end #end initialize method

    def self.all
      driver_array = []
      CSV.open('support/drivers.csv', 'r', :headers => true).each do |line|
        id = line["driver_id"].to_i
        name = line["name"].to_s
        vin = line["vin"].to_s
        driver_array << self.new(id, name, vin)
      end
      return driver_array
    end

    def self.find(id)
      Driver.all.each do |file|
        if file.id == id
          return file
        end
        #  "We did not find this ID"
      end
    end
    #Should be able to retrieve list of trip instances that a specific driver has taken
    #Should be able to retrieve the average rating for that driver based on all trips taken
    #Have to use all method in find method
    #create method that uses method from trip object to retrieve list of trips
    #create method that uses internal trips list to calculate average rating
  end
end
