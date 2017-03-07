#Create Rideshare module
module Rideshare
#Create Driver class
  class Driver
    attr_reader :id, :name, :license_num, :vin
#an ID, name, license number, vehicle identification number should be initialized\
    def initialize(args)
      @id = args[:id]
      @name = args[:name]
      @license_num = ""
      @vin = args[:vin]
      raise ArgumentError.new("Not a valid vin number") if @vin.length > 17
    end
#(vehicle id # should be a specific length to ensure it's a valid vehicle)

#instance_method1 : retrieve the list of trip instances that only this drver has taken
#instance_method2 : retrieve an average rating for that driver based on all trips taken

#self.method1 : retrive all drivers from the CSV file
#self.method2 : find a specific driver using their numeric ID
  end
end
