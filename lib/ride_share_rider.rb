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
      self.all.each do |rider|
        return rider if rider[:id] == id_num
      end
    end
#instance_method1 : retrieve the list of trip instances that only this drver has taken
    def all_trips
    end
#instance_method2 : retrieve an average rating for that rider based on all trips taken
    def average_rating
    end

  end
end

# puts Rideshare::Driver.all.last
# Rideshare::Driver.new(id: 1, name: "Bernardo Prosacco", vin: "WBWSS52P9NEYLVDE9")
