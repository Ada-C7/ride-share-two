require 'csv'
require'pry'

module Rideshare
  class RideshareData
    attr_reader :id
    def initialize(args)

      raise ArgumentError.new("Warning: #{args.keys[1]}#  #{args.values[1]} is missing information") if args.values.any? == "" || args.values.any? == 0 || args.values.any? == nil

      @id = args[:driver_id]
      @vin = args[:vin]
      @name = args[:name]

    end

    def self.all(csv_filename)
      #formats numbers properly
      csv= CSV.read(csv_filename,
      { headers: true,
        header_converters: :symbol,
        converters: :all
        })

        csv.map do |row|
          args = row.to_hash
          begin
            self.new(args)
          rescue
            #if I had time I would make an error log here
          end

        end
      end


      def self.find_records(csv_filename, type, id_to_find)
        fail = proc {
          raise ArgumentError.new("#{type} # #{id_to_find}. Does not exist")
        }
        self.all(csv_filename).find(fail) do |record|
          record.id == id_to_find
        end
      end
    end
  end




  x = Rideshare::RideshareData.find_records('../support/drivers.csv', "Driver",500)
  puts x
