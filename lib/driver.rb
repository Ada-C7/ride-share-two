require "csv"

module RideSharing
  class Driver
    attr_reader :id, :name, :vin
    def initialize(driver_hash)
      raise ArgumentError.new("The input for :id must be an integer > 0.\nThis driver will not be recorded.") if  driver_hash[:driver_id].class != Integer || driver_hash[:driver_id] < 1
      raise ArgumentError.new("The input for :name must be a string of at least 3 readable characters.\nThis driver will not be recorded.") if  driver_hash[:name].class != String || driver_hash[:name].delete(" ").length < 3
      raise ArgumentError.new("The input for :vehicle number (vin) must be a string of 17 characters (no white space).\nThis driver will not be recorded." ) if driver_hash[:vin].class != String || driver_hash[:vin].delete(" ").length != 17

      @id = driver_hash[:driver_id]
      @name = driver_hash[:name]
      @vin = driver_hash[:vin]
    end

    def self.all(path = "./support/drivers.csv")
      all_drivers = []
      CSV.foreach(path, :headers => true, :header_converters => :symbol) do |row|
        begin
          raise ArgumentError.new("The driver_id \"#{row[0]}\" creates an invalid id number. The id number must be an integer > 0.\nHence this driver will not be recorded." ) if row[0] == nil || row[0].to_i < 1
        rescue ArgumentError => exception
          puts "#{exception.message}"
          next
        end

        begin
          raise ArgumentError.new("The input name for driver_id #{row[0]} must be at least 3 readable character long.\nHence this driver will not be recorded." ) if row[1] == nil || row[1].delete(" ").length < 3
        rescue ArgumentError => exception
          puts "#{exception.message}"
          next
        end

        begin
          raise ArgumentError.new("Vehicle number (vin) not valid for driver_id #{row[0]}. It must be 17 characters long (no white space)\nHence this driver will not be recorded." ) if row[2] == nil || row[2].delete(" ").length != 17
        rescue ArgumentError => exception
          puts "#{exception.message}"
          next
        end

        driver_hash = row.to_hash
        driver_hash[:driver_id] = driver_hash[:driver_id].to_i
        all_drivers << self.new(driver_hash)
      end
      return all_drivers
    end

    def self.find(driver_id)
      found_driver = self.all.select { |driver| driver.id == driver_id}
      begin
        raise ArgumentError.new("Id number #{driver_id} does not exist") if found_driver == []
      rescue ArgumentError => exception
        puts "#{exception.message}"
      end
      return found_driver.first
    end

    def list_of_trips
      RideSharing::Trip.find_all_trips_for_driver(@id)
    end

    def average_rating
      if list_of_trips != []
        return list_of_trips.map { |trip| trip.rating}.sum.to_f/ list_of_trips.length
      else
        puts "#{@name} with id##{@id} has not yet taken any trips.\nHence the average rating cannot be calcualted"
        return Float::NAN
      end
    end

  end # End of class Driver
end # End of module RideSharing
