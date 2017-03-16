module Rideshare
  class Record

    def self.all(search_var)
      csv = CSV.read(self.csv_name,
      { headers: true,
        header_converters: :symbol,
        converters: :all  # format Integers
        })

        csv.map do |row|
          args = row.to_hash
          self.new(args, search_var)
        end
    end

    def self.find_records(search_var, id_to_find)
        self.all(search_var).find_all do |record|
          record.id == id_to_find
        end
      end
    end
  end
  # raise ArgumentError.new("Driver # #{id_to_find} does not exist")if x.length == 0
