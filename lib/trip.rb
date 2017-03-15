module Rideshare
  class Trip < Rideshare::Record
    attr_reader :id, :trip_id, :driver_id, :name, :rating, :rider_id

    def initialize(args, search_var)
      @id = args[search_var]
      @trip_id = args[:trip_id]
      @driver_id = args[:driver_id]
      @rider_id = args[:rider_id]
      @date = args[:date]  # included for future functionality; not needed
      @rating = args[:rating]
    end

    def self.csv_name
      "support/trips.csv"
    end

    def self.all(search_var)
      super(search_var)
    end

    def self.find_records(search_var, id_to_find)
      super(search_var, id_to_find)
    end
    #
    # private
    # def proof_data
    #   raise ArgumentError.new("Warning: bad VIN: #{args[:vin]}; Driver #{args[:driver_id]} data not included ") if args[:vin].length != 17
    # end
  end
end
