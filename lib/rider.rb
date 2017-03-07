require_relative 'trip'

class Rider

     attr_reader :id, :name, :phone
     attr_accessor :trips, :average_rating

     def initialize(id, name, phone)
          @id = id
          @name = name
          @phone = phone
          #@trips = recall_trips
          #@average_rating = calculate_average_rating
     end

     # #retrieve the list of trip instances that only this rider has taken
     # def recall_trips(@id)
     #      #TODO Build block after trip.rb has been completed.
     #      #Calls Trip class method to retrieve list of trip instances according to @id.
     #      #@trips = Trip.find(@id)
     #      #return @trips
     # end
     

     # def self.all(file)
     #      all_drivers = []
     #
     #      CSV.open(file).each do | line |
     #           @id = line[0].to_i
     #           @name = line[1]
     #           @vin = line[2]
     #           driver = Driver.new(@id, @name, @vin)
     #           all_drivers << driver
     #      end
     #
     #      return all_drivers
     # end
     #
     # def self.find(file, id)
     #
     #      Driver.all(file).each do | account |
     #
     #           if account.id == id
     #                return account
     #           end
     #
     #      end
     #
     #      raise ArgumentError.new "Driver #{id} does not exist."
     #
     # end
end
