require 'csv'

module RideShare

  class Rider
    attr_reader :id, :name, :phone_number
    def initialize(id, name, phone_number)
      @id = id.to_i
      @name = name
      @phone_number = phone_number
    end

  def self.all
    rider_array = []
    CSV.open('support/riders.csv', 'r', :headers => true).each do |line|
      id = line["rider_id"].to_i
      name = line["name"].to_s
      phone_number = line["phone_number"].to_s
      rider_array << self.new(id, name, phone_number)
    end
    return rider_array
  end



    #Each rider should have an ID, name, and phone number
    #Should be able to retrieve the list of trip instances that only this specific rider has taken
    #Retrieve list of all previous driver instances
    #Uses the all method in find method
    #Creates method that uses a method from trip object to retrieve list of trips
    #Create method that uses internal trips method to retrieve associated drivers

  end
end
