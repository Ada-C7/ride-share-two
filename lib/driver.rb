require 'csv'
require_relative 'invalid_vin_error'

module RideShare
  class Driver
    attr_reader :name, :id, :vin

    def initialize(args)
      if args[:vin].length != 17 || !all_letters_and_numbers?(args[:vin])
        raise RideShare::InvalidVinError.new("VIN must be 17 characters long and only contain letters and numbers")
      end

      @name = args[:name]
      @id = args[:id]
      @vin = args[:vin]
    end

    


    private

    # determine whether a string contains only letters a-z and numbers 0-9
    def all_letters_and_numbers?(str)
      str[/[a-zA-Z0-9]+/] == str
    end
  end
end
