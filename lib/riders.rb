
module RideShare

  class Rider
    attr_reader :id, :name, :phone_num

    def initialize(args)
      @id = args[:id]
      @name = args[:name]
      @phone_num = (args[:phone_num])
    end

    def self.all
      riders_array = []
      CSV.read("support/riders.csv", {:headers => true}).each do |rider|
        begin
          args = {
          :id => rider[0],
          :name => rider[1],
          :phone_num => rider[2]
          }
          riders_array << (Rider.new(args))
        rescue InvalidPhoneError
          #this will only apply if csv has errors
          riders_array << (Rider.new(rider[0], rider[1], nil))
          puts "Invalid phone number for rider #{id}"
        end
      end
      riders_array
    end

    def self.find(id)
      riders_array = self.all
      riders_array.find { |rider| id == rider.id }
    end

    #retrieve the list of trip instances
    #that only this rider has taken
    def trips
      RideShare::Trip.find_by_rider(id)
    end

    #retrieve the list of all
    #previous driver instances
    #(through the trips functionality built above)
    def drivers
      rider_trips = trips
      rider_trips.collect! { |trip| trip.find_driver }
      rider_trips.uniq { |driver| driver.id }
    end
  end
end
