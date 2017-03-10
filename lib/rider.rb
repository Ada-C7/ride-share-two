require 'csv'
require 'pry'

# require_relative 'driver'
# require_relative 'trip'
module Rideshare
  #
  class Rider
    attr_reader :rider_id, :name, :phone_num

    def initialize(trip_hash)

      @rider_id = trip_hash[:rider_id]
      @phone_num = trip_hash[:phone_num]
      @name = trip_hash[:name]

    end

    def self.create_rider
      hash = {}
      CSV.foreach('support/riders.csv', {:headers => true, :header_converters=> :symbol}) do |row|
        hash[row[0]] = Rider.new({rider_id:row[0], name:row[1], phone_num:row[2]})
      end
      return hash
    end


    def self.find_rider(param)

      CSV.foreach('support/riders.csv', {:headers=> true, :header_converters => :symbol}) do |row|
        return  Rider.new({rider_id:row[0], name:row[1], phone_num:row[2]}) if row[0] == param.to_s
      end
    end

  end
end
#

#
#
#
