require_relative 'records.rb'
require_relative 'trip.rb'
require_relative 'vin_error.rb'
require 'csv'
require 'pry'
module Rideshare
  class Driver < Rideshare::Record
    attr_reader :vin, :driver_id, :name, :id

    def initialize(args, search_var)
      args[:id] = args[search_var]

      #current policy is to delete ALL records that contain ANY questionable data
      proof_data(args)

      @id = args[:id]
      @driver_id = args[:driver_id]
      @vin = args[:vin]
      @name = args[:name]
    end

    def add_record
      super(args, search_var)
    end

    def proof_data(args)
      super(:driver, args)

      raise VinError.new("Driver #{args[:driver_id]} removed from dataset due to bad vin.") unless args[:vin].nil? || args[:vin].length == 17
    end

    def self.csv_name
      "support/drivers.csv"
    end

    def self.all(search_var)
      super(search_var)
    end

    def self.find_records(search_var, id_to_find)
      super(search_var, id_to_find.to_i)
    end

    def self.subset_driver_trips(id_to_find)
      Rideshare::Trip.find_records(:driver_id, id_to_find.to_i)
    end

    def self.driver_rating(trips)
      total_trips = trips.length
      trips.select! { |x| (1..5).include? x.rating }

      if trips.length == 0
        average_rating = nil
        puts "No valid ratings for Driver"
      else
        trips.map! { |y| y.rating}
        average_rating = (trips.sum * 1.0 / trips.length).round(1)
      end

      if trips.length < total_trips
        puts "#{total_trips - trips.length} trips not included in calculations due to missing or out-of-acceptable-range ratings."
      end

      average_rating

    end

    def self.get_driver_rating(id_to_find)
      driver_rating(self.subset_driver_trips(id_to_find))
    end

  end
end
