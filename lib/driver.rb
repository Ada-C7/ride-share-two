require "csv"

module RideSharing
  class Driver

    attr_reader :id, :name, :vin
    def initialize(driver_hash)
      @id = driver_hash[:driver_id].to_i
      @name = driver_hash[:name].to_s
      @vin = driver_hash[:vin].to_s
    end

    # def initialize(id, name, vin)
    #   @id = id
    #   @name = name
    #   @vin = vin
    # end

    def self.all(path = "./support/drivers.csv")
      all_drivers = []
      CSV.foreach(path, :headers => true, :header_converters => :symbol) do |row|
        begin
          raise ArgumentError.new("Vehicle number (vin) not valid for\ndriver \"#{row[1]}\" with id# #{row[0]}.\nHence this driver will not be recorded." ) if row[2].length != 17
        rescue ArgumentError => exception
          puts "#{exception.message}"
          next
        end
        all_drivers << self.new(row.to_hash)
      end
      return all_drivers
      # all_drivers =[]
      # CSV.foreach(path, {:headers => true}) do |line_array|
      # # CSV.open(path).each do |line_array|
      #   begin
      #     raise ArgumentError.new("Vehicle number (vin) not valid for\ndriver \"#{line_array[1]}\" with id# #{line_array[0]}.\nHence this driver will not be recorded." ) if line_array[2].length != 17
      #   rescue ArgumentError => exception
      #     puts "#{exception.message}"
      #     next
      #   end
      #   all_drivers << self.new(line_array[0].to_i, line_array[1], line_array[2])
      # end
      # return all_drivers
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
      # begin
      #   list_of_trips.map { |trip| trip.rating}.sum.to_f/ list_of_trips.length
      # rescue
      #   puts "#{@name} with id##{@id} has not yet taken any trips.\nHence the average rating cannot be calcualted"
      #   Float::NAN
      # end
      if list_of_trips != []
        return list_of_trips.map { |trip| trip.rating}.sum.to_f/ list_of_trips.length
      else
        puts "#{@name} with id##{@id} has not yet taken any trips.\nHence the average rating cannot be calcualted"
        return Float::NAN
      end
    end



  end # End of class Driver
end # End of module RideSharing
