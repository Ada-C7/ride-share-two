class Rider

#@@riders = {} #or []

#def initiatize
# @id = rider_hash[:rider_id]
# @name = rider_hash[name:]
# @phone_number = rider_hash[phone_number:]
#end

#def trips_taken
#rider_id = @rider_id
#maybe use Trip::find_rider(rider_id)
# return list of trips taken by this rider
#end

#def previous_drivers
#retrieve the list of all previous rider instances from trips_take method
#return list of all previous drivers
#end

#def self.all
#reads csv
#creates rider instances
#returns all riders
#end

#def self.find(rider_id)
#checks @@riders
#returns rider data with associating id
#end

end



module Carmmunity
  class Rider

    #@@riders = []

    attr_reader :rider_id, :name, :phone_number

    def initialize(rider_hash)
      @rider_id = rider_hash[:rider_id]
      @name = rider_hash[:name]
      @phone_number = rider_hash[:phone_number]
      # vin number should be a specific length to ensure it is a valid vehicle identification number <-method?
    end

    def trips_taken
      trips = Carmmunity::Trip.find(@rider_id)
      return trips
    end


    def previous_drivers

      my_trips = trips_taken

      my_drivers_ids = my_trips.driver_id.map

      drivers = my_drivers_ids.map { |id| Carmmunity::Trip.find(id) }

      return drivers
    end


  def self.find(id)

    #@@riders.find do |rider|
    all_riders = self.all

    all_riders.find do |rider|

      if rider.rider_id == id
        return rider
      end
    end

    raise ArgumentError.new "#{id} returned no results"
  end #end self.find



    def self.all

      #if @@riders.length == 0
      riders = []

        CSV.read("support/riders.csv").each do |row|
          rider = {
            rider_id: row[0].to_i,
            name: row[1],
            phone_number: row[2]
          }

          riders << Carmmunity::Rider.new(rider)
          #@@riders << Carmmunity::Rider.new(rider)

        end
      #end
      return riders#@@riders
    end #

  end #end of class
end #end of module
