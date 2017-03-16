module Rideshare
  class Rider
    def initialize(args)
      proof(args)
      @id = args[:varname]
      @rider_id = args[:rider_id]
      @name = args[:name]
      @phone_num= args[:phone_num]
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
