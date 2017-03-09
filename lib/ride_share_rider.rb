require 'csv'

#Create Rideshare module
module Rideshare
#Create Rider class
  class Rider
    attr_reader :id, :name, :phone_num
#an ID, name, phone number should be initialized
    def initialize(args)
      @id = args[:id]
      @name = args[:name]
      @phone_num = args[:phone_num]
      raise ArgumentError.new("Not a valid ID") if @id.class != Integer
    end

#self.method1 : retrive all riders from the CSV file
    def self.all
      csv = []
      CSV.read("./support/riders.csv").drop(1).each do |rider|
        csv.push({id: rider[0].to_i, name: rider[1], phone_num: rider[2]})
      end
      return csv
    end

#self.method2 : find a specific rider using their numeric ID
    def self.find(id_num)
      raise ArgumentError.new("Not a valid ID number") if id_num.class != Integer
      result  = all.find {|rider| rider[:id] == id_num}
      result ||= "No match"
    end

#instance_method1 : retrieve the list of trip instances that only this rider has taken
    def all_trips
      return Rideshare::Trip.find_trip_by_rider(@id)
    end

#instance_method2 : retrieve the list of all previous drvier instances
    def all_drivers
      if all_trips.class != String
        drivers = all_trips.map{|h| h[:driver_id]}
        return drivers.map {|driver| Rideshare::Driver.find(driver)}.uniq
      else
        return "No Match"
      end
    end

  end
end
