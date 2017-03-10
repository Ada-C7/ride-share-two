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

      cleaned_array = read_file.delete_if do |row|
        row == read_file[0]
      end

      riders_array = []
      cleaned_array.map do |var|
        rider = self.new(var[0].to_s, var[1].to_s,  var[2].to_s)

        riders_array << rider
      end
      return riders_array
    end

    def self.find(rider_id)
      riders = RideShare::Rider.all
      counter = 0
      # puts riders[counter].rider_id.is_a? String
      # puts rider_id.is_a? String

      riders.each do |rider|
        if rider.rider_id == rider_id
          return rider.name
        else
          counter += 1
        end
      end

    end

    def trips
    end

  end
end


# test_1 = RideShare::Rider.all
#
# # puts test_1

# test_1 = RideShare::Rider.find("50")
#
# puts test_1
