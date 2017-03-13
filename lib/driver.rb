require 'pry'
require 'csv'
require_relative 'record_magic.rb'

module Rideshare
  class Driver
    extend RecordMagic
    attr_reader :id, :vin, :driver_id, :name

    def initialize(args, varname)
      @id = args[:varname]
      @driver_id = args[:driver_id]
      @vin = args[:vin]
      @name = args[:name]
    end

    def get_driver_instance(driver_id)
      find_records('csv = ../support/driver.rb', "Driver", driver_id)
    end

    def get_trips(driver)
      get_trips(driver, :driver_id)
    end

    def get_avg_rating(driver)
      get_trips(driver).rating.sum / length(get_trips)
    end

    private
    def proof_data
      raise ArgumentError.new("Warning: bad VIN: #{args[:vin]}; Driver #{args[:driver_id]} data not included ") if args[:vin].length != 17
    end
  end
end
