module Rideshare
  class Trip < Rideshare::Record
    attr_reader :id, :trip_id, :driver_id, :name, :rating, :rider_id, :date

    def initialize(args, search_var)
      # current policy is to eliminate ALL records that contain questionable driver, rider, or trip id

      # missing or faulty rating or date are OK.
      proof_data(args)

      @id = args[search_var]
      @trip_id = args[:trip_id].to_i
      @driver_id = args[:driver_id].to_i
      @rider_id = args[:rider_id].to_i
      @date = args[:date]  # included for future functionality; not needed
      @rating = args[:rating]
    end

    def proof_data(args)

      # subset hash to only required info (trip_id, rider_id, driver_id)
      # fill in nil if missing any critical values
      must_haves = { trip_id: nil, driver_id: nil,  rider_id: nil }
      must_haves.merge! args.select { |k, v| must_haves.keys.include? k }

      super(:trip_id, must_haves)

      puts "Warning: invalid rating for trip ##{args[:trip_id]}" unless (1..5).include? args[:rating]
    end

    def self.csv_name
      "support/trips.csv"
    end

    def self.add_record(args, search_var)
      super(args, search_var)
    end

    def self.all(search_var)
      super(search_var)
    end

    def self.find_records(search_var, id_to_find)
      super(search_var, id_to_find)
    end
  end
end
