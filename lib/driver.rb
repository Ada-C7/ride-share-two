module RideShare
  class Driver
    attr_reader :name, :id, :vin

    def initialize(args)
      raise ArgumentError.new("VIN must be a string") unless args[:vin].is_a? String

      if args[:vin].length != 17 || !all_letters_and_numbers?(args[:vin])
        raise RideShare::InvalidVinError.new("VIN must be 17 characters long and
          only contain letters and numbers")
      end

      @name = args[:name]
      @id = args[:id]
      @vin = args[:vin]
    end

    def self.all
      drivers = []
      CSV.foreach('support/drivers.csv', headers: true) do |row|
        drivers << self.new(id: row['driver_id'].to_i, name: row['name'], vin: row['vin'])
      end
      return drivers
        #CSV.foreach('support/drivers.csv', headers: true, header_converters: :symbol) do |row|
    end

    def self.find(driver_id)
      self.all.find {|driver| driver.id == driver_id}
      # If no driver is found, returns nil
    end

    private

    # determine whether a string contains only letters a-z and numbers 0-9
    def all_letters_and_numbers?(str)
      str[/[a-zA-Z0-9]+/] == str
    end
  end
end
