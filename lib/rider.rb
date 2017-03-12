require 'csv'

module RideShare
  class Rider
    attr_accessor :rider_id, :name, :phone_num

    def initialize(rider_id, name, phone_num)
      @rider_id = rider_id
      @name = name
      @phone_num = phone_num
    end



    def self.all_rider_info
      all_rider_info = []
      CSV.read('support/riders.csv').each do |object|
        rider_id = object[0].to_i
        name = object[1].to_s
        phone_num = object[2].to_s

        #I do this below so that I can actually do something with the variables
        a_ride = RideShare::Rider.new(rider_id, name, phone_num)
        all_rider_info << a_ride
      end
        return all_rider_info
    end

    def self.find_rider(rider_id)
      rider_info = []
      all_riders = RideShare::Rider.all_rider_info
      all_riders.each do |object|
        if object.rider_id = rider_id
          rider_info << object
        end
          return rider_info
      end
    end





  end
end

# rider_id,name,phone_num
# # 1,Nina Hintz Sr.,560.815.3059
# 2,Kaia Klocko,(392) 217-0777
# 3,Marcellus Hoeger,(222) 926-0138
# 4,Ervin Wiza,272-041-9587
