require_relative 'trip'

class Rider

     attr_reader :id, :name, :phone
     attr_accessor :trips

     def initialize(id, name, phone)
          @id = id
          @name = name
          @phone = phone
          #@trips = recall_trips
     end

     # #retrieve the list of trip instances that only this rider has taken
     # def recall_trips(@id)
     #      #TODO Build block after trip.rb has been completed.
     #      #Calls Trip class method to retrieve list of trip instances according to @id.
     #      #@trips = Trip.find(@id)
     #      #return @trips
     # end

     def self.all(file)
          all_riders = []

          CSV.open(file).each do | line |
               @id = line[0].to_i
               @name = line[1]
               @phone = line[2]
               rider = Rider.new(@id, @name, @phone)
               all_riders << rider
          end

          return all_riders
     end

     def self.find(file, id)

          Rider.all(file).each do | rider |

               if rider.id == id
                    return rider
               end

          end

          raise ArgumentError.new "Rider #{id} does not exist."

     end
end
