module Rideshare
  class Driver < Rideshare::Record
    attr_reader :vin, :driver_id, :name, :id

    def initialize(args, search_var)
      proof_data(args)
      @id = args[search_var]
      @driver_id = args[:driver_id]
      @vin = args[:vin]
      @name = args[:name]
    end

    def proof_data(args)
      begin
        raise ArgumentError.new("Warning: bad VIN: #{args[:vin]}; Driver #{args[:driver_id]} data not included ") if args[:vin].length != 17
      rescue
      end

      begin
        raise ArgumentError.new("Warning: Driver name not reported") unless (args[:name].is_a? String) && (args[:name].length > 0)
      rescue
        puts "Data included anyway"
      end
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


# the base funcionality (ie find, all) are in the RecordsMagic module
#   def self.get_driver_instances(driver_id)
#     find_records('../support/drivers.csv', :driver, driver_id)
#   end
#
#   def self.get_trips(driver)
#     Trip.get_trips_by_var(driver, :driver_id)
#   end
#
#   def self.get_avg_rating(driver)
#     get_trips(driver).rating.sum / length(get_trips)
#   end
#
#   private
#   def proof_data
#     raise ArgumentError.new("Warning: bad VIN: #{args[:vin]}; Driver #{args[:driver_id]} data not included ") if args[:vin].length != 17
#   end
