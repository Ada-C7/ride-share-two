require 'pry'
require 'csv'
require_relative 'record_magic.rb'

module Rideshare
  class Trip
    extend RecordMagic
    attr_reader :id, :trip_id, :driver_id, :name, :rating, :rider_id

    def initialize(args, search_var)
      @id = args[search_var]
      @trip_id = args[:trip_id]
      @driver_id = args[:driver_id]
      @rider_id = args[:rider_id]
      @date = args[:date]  # included for future functionality; not needed
      @rating = args[:rating]
    end

    def self.get_trips(id_to_find, search_var)
      find_records("../support/trips.csv",search_var, id_to_find)
    end

    private
    def proof_data
      raise ArgumentError.new("Warning: bad VIN: #{args[:vin]}; Driver #{args[:driver_id]} data not included ") if args[:vin].length != 17
    end
  end
end

x = Rideshare::Trip.get_trips(100, :rider_id)
puts x.rider_id
