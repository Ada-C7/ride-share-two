require 'pry'
require 'csv'
require_relative 'record_magic.rb'

module Rideshare
  class Driver
    extend RecordMagic
    attr_reader :id, :vin, :name

    def initialize(args)
      @id= args[:driver_id]
      @vin = args[:vin]
      @name = args[:name]
    end

    private

    def proof_data
      raise ArgumentError.new("Warning: bad VIN: #{args[:vin]}; Driver #{args[:driver_id]} data not included ") if args[:vin].length != 17

      raise ArgumentError.new("Warning: Bad driver ID: must be a number, but was reported as #{args[:driver_id]} data not included ") unless (args[:driver_id].is_a? Integer) && (args[:driver_id] > 0 )

      raise ArgumentError.new("Warning: Driver name not reported") unless (args[:name].is_a? String) && (args.length > 0)
    end
  end
end
