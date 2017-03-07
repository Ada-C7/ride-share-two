# Rider
#
# Each rider should:
#
# TODO: have an ID, name and phone number

# Given a rider object, you should be able to:
#
# TODO: retrieve the list of trip instances that only this rider has taken
# TODO: retrieve the list of all previous driver instances (through the trips functionality built above)

# You should be able to:
#
# TODO: retrieve all riders from the CSV file
# TODO: find a specific rider using their numeric ID

require 'csv'

module RideShare
  class Rider
    def initialize (rider_id, name, phone_num)
      @rider_id = rider_id
      @name = name
      @phone_num = phone_num
      @riders_array = []
    end

    def self.all
      read_file = CSV.read('support/rider.csv')

      read_file.map do |line|
        @rider_id = line[0].to_i
        @name = line[1].to_s
        @phone_num = line[2].to_s
        new_rider = RideShare::Driver.new(@rider_id, @name, @phone_num)
        riders_array << new_rider
      end
      return riders_array
    end

  end
end
# test_1 = RideShare::Rider.new(213124, "jake", "jkdfr435")
#
# puts test_1
