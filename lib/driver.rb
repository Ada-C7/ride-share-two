require_relative 'trip'


class Driver

     attr_reader :id, :name, :vin
     attr_accessor :trips, :average_rating

     def initialize(id, name, vin)
          raise ArgumentError if vin.class != String || vin.length > 17
          @id = id
          @name = name
          @vin = vin
          #@trips = recall_trips
          #@average_rating = calculate_average_rating
     end

     # #retrieve the list of trip instances that only this driver has taken
     # def recall_trips(@id)
     #      #TODO Build block after trip.rb has been completed.
     #      #Calls Trip class method to retrieve list of trip instances according to @id.
     #      #@trips = Trip.find(@id)
     #      #return @trips
     # end
     #
     # #retrieve an average rating for that driver based on all trips taken
     # def calculate_average_rating(@id)
     #      #TODO Build block after trip.rb has been completed.
     #      all_trips = recall_trips(@id)
     #      @average_rating = all_trips.rating.map { | sum, rating | sum + rating }/all_trips.length
     #      return @average_rating
     # end

     # def self.all(file)
     #      all_accounts = []
     #      CSV.open(file).each do | line |
     #           id = line[0].to_i
     #           balance = line[1].to_i
     #           date_opened = line[2]
     #           account = Account.new(id, balance, date_opened)
     #           all_accounts << account
     #      end
     #
     #      return all_accounts
     # end
end
