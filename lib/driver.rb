require_relative 'records.rb'
require 'csv'
require 'pry'
module Rideshare
  class Driver < Rideshare::Record
    attr_reader :vin, :driver_id, :name, :id

    def initialize(args, search_var = :driver_id)

      raise ArgumentError.new("Warning: Bad VIN for Driver #{args[:driver_id]}  Data excluded.") unless args[:vin].length == 17

      raise ArgumentError.new("Warning: Driver #{args[:driver_id]} is missing information if") if ( args.values & [0,"", nil]).any?


      @id = args[search_var]
      @driver_id = args[:driver_id]
      @vin = args[:vin]
      @name = args[:name]
    end

    def self.csv_name
      "support/drivers.csv"
    end

    def self.all(search_var)
      super(search_var)
    end

    def self.find_records(search_var, id_to_find)
      super(search_var, id_to_find)
    end
  end
end
