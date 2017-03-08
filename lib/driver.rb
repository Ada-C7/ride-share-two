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
      CSV.foreach(path, {:headers => true}) do |line_array|
      # CSV.open(path).each do |line_array|
        begin
          raise ArgumentError.new("Vehicle number (vin) not valid for driver \"#{line_array[1]}\" with id# #{line_array[0]}" ) if line_array[2].length != 17
        rescue ArgumentError => exception
          puts "#{exception.message}"
          next
        end
        all_drivers << self.new(line_array[0].to_i, line_array[1], line_array[2])
      end
      return all_drivers
    end

    def self.find(driver_id)
      found_driver = self.all.select { |driver| driver.id == driver_id}
      raise ArgumentError.new("No such id number exist") if found_driver == []
      return found_driver.first
    end


  end # End of class Driver
end # End of module RideSharing
