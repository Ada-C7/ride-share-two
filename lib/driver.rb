require_relative 'records.rb'
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
      super("Driver", args)

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
  end
end


# all_drivers = Rideshare::Driver.all(:driver_id)
# puts all_drivers.length
# puts all_drivers[82].nil?
