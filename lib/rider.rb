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
    attr_reader :rider_id, :name, :phone_num
    def initialize (rider_id, name, phone_num)
      @rider_id = rider_id
      @name = name
      @phone_num = phone_num
    end

    def self.all
      # TODO: Clean up variable names.
      read_file = CSV.readlines('support/riders.csv')

      riders_array = CSV.readlines('support/riders.csv').delete_if do |row|
        row == read_file[0]
      end

      riders_array_2 = []
      riders_array.each do |var|
        rider_id = var[0].to_s
        name = var[1].to_s
        phone_num = var[2].to_s
        rider = RideShare::Rider.new(rider_id, name, phone_num)

        riders_array_2 << rider
      end
    end

    def self.find
    end

    def trips
    end

  end
end

###TEST###
# read_file = CSV.readlines('support/riders.csv')
#
# riders_array = read_file.delete_if do |row|
#   row == read_file[0]
# end
# # print riders_array
# # puts riders_array.is_a? Array
# # print riders_array[0]
#
# riders_array_2 = []
#
# riders_array.each do |var|
#   id = var[0].to_i
#   name = var[1].to_s
#   phone_num = var[2].to_s
#   rider = RideShare::Rider.new(id, name, phone_num)
#   riders_array_2 << rider
# end
#
# print riders_array_2
# puts riders_array_2.is_a? Array
# puts riders_array_2[0[0]]
# puts riders_array_2[0[id]].is_a? Integer
###TEST###

test_1 = RideShare::Rider.all

# puts test_1
