require "csv"

module RideSharing
  class Driver

    attr_reader :id, :name, :vin
    def initialize(id, name, vin)

      @id = id
      @name = name
      @vin = vin
    end

    def self.all(path = "./support/drivers.csv")
      all_drivers =[]
      CSV.open(path).each do |driver|
        begin
          raise ArgumentError.new("Vehicle number (vin) not valid for driver #{driver[1]} with id# #{driver[0]}" ) if driver[2].length != 17
        rescue ArgumentError => exception
          puts "#{exception.message}"
          next
        end
        all_drivers << self.new(driver[0], driver[1], driver[2])
      end
      return all_drivers
    end


  end # End of class Driver
end # End of module RideSharing
