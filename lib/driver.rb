require 'csv'
require 'pry'
# require_relative 'module.rb'

# require_relative 'trip'
# require_relative 'missingiderror'
# require_relative 'rider'
#
module Rideshare
  class Driver
    attr_reader :driver_id, :name
    def initialize(trip_hash)
      @driver_id = trip_hash[:driver_id]
      @vin = trip_hash[:vin]
      @name = trip_hash[:name]

    end

    def self.create_drivers
      hash = {}
      CSV.foreach('support/drivers.csv', {:headers => true, :header_converters=> :symbol}) do |row|
        hash[row[0]] =Driver.new({driver_id:row[0], name:row[1], vin:row[2]})
      end
      return hash
    end


    def self.find_driver(param)
      array = []
      CSV.foreach('support/drivers.csv', {:headers=> true}) do |row|
        array <<  Driver.new({driver_id:row[0], name:row[1], vin:row[2]}) if row[0] == param.to_s
      end
      # array.length < 0 ? (raise StandardError.new("That driver does not exist in our service")) :(array = value)
      return array
    end

    def all_my_trips
      return Trip.find_by_driver(@driver_id)
    end

    def driver_rating
      array = Trip.find_by_driver(@driver_id)
       array.map!{|value| value.rating.to_i}
       return array.reduce(:+)/array.length
    end
  end
end
