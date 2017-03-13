require_relative 'record_magic'
module Rideshare
  class Driver
    extend RecordMagic
    attr_reader :id, :vin, :driver_id, :name

    def initialize(args, search_var)
      proof_data
      @id = args[:search_var]
      @driver_id = args[:driver_id]
      @vin = args[:vin]
      @name = args[:name]
    end

    # the base funcionality (ie find, all) are in the RecordsMagic module

    def self.get_driver_instances(driver_id)
      find_records('csv = ../support/driver.rb', :driver, driver_id)
    end

    def self.get_trips(driver)
      Trip.get_trips_by_var(driver, :driver_id)
    end

    def self.get_avg_rating(driver)
      get_trips(driver).rating.sum / length(get_trips)
    end

    private
    def proof_data
      raise ArgumentError.new("Warning: bad VIN: #{args[:vin]}; Driver #{args[:driver_id]} data not included ") if args[:vin].length != 17
    end
  end

end
puts Rideshare::Driver.get_trips(2)
