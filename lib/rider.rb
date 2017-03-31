module Rideshare
  class Rider < Rideshare::Record

    attr_reader :phone_num, :rider_id, :name, :id

    def initialize(args, search_var)
      proof_data(args)
      @id = args[search_var]
      @rider_id = args[:rider_id]
      @name = args[:name]
      @phone_num= args[:phone_num]
    end

    def proof_data(args)
      must_haves = { rider_id: nil, phone_num: nil,  name: nil }
      must_haves.merge! args
      super(:rider_id, must_haves)
    end

    def self.csv_name
      "support/trips.csv"
    end

    def self.all(search_var)
      super(search_var)
    end

    def find_records(search_var, id_to_find)
      super(search_var, id_to_find)
    end
  end
end
