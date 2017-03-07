
  class RideShare::Rider
    attr_reader :id, :name, :phone_num

    def initialize(rider_data)
      @id = rider_data[:id]
      @name = rider_data[:name]
      @phone_num = rider_data[:phone_num]
    end

    def riders
    end

    def self.all
      rider_array = []
      CSV.open("support/riders.csv", 'r').each do |rider|
        new_rider = RideShare::Rider.new({
          :id => rider[0],
          :name => rider[1],
          :phone_num => rider[2]
          })
          rider_array << new_rider
      end
      rider_array.shift
      return rider_array
    end

    def self.find
    end

  end
