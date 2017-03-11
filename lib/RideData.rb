require 'csv'

module Rideshare
  class RideData
    def initialize(args)
      raise ArgumentError.new("Warning: at least one row contains nil data") if args.values.any? == "" || arg.values.any == 0 || args.values.any == nil
    end

    def self.all(csv_filename)
      #formats numbers properly
      dat = CSV.read(csv_filename)


      [1..-1].map do |row|
        args = { driver_id: row[0].to_i, vin: row[2], name: row[1] }
        begin
          self.new(args)
        rescue
          # if I had time, I would make class ErrorLogger to write the errors to a csv file
        end
      end
    end
  end
