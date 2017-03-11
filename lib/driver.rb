module RideShare
  class Driver
    attr_reader :name, :id, :vin

    def initialize(args)
      check_if_valid_vin(args[:vin]) if args[:vin] != nil

      @name = args[:name]
      @id = args[:id]
      @vin = args[:vin]
    end

    # retrieves the list of trip instances that only this driver has taken
    def trips
      RideShare::Trip.find_all_for_driver(@id)
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

    def check_if_valid_vin(vin)
      raise ArgumentError.new("VIN must be a string") unless vin.is_a? String

      if vin.length != 17 || !all_letters_and_numbers?(vin)
        raise RideShare::InvalidVinError.new("VIN must be 17 characters long and
          only contain letters and numbers")
      end
    end
  end
end
