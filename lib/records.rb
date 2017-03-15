module Rideshare
  class Record

    def proof_data

      raise ArgumentError.new("Warning: Bad driver ID: must be a number, but was reported as #{args[:driver_id]} data not included ") unless (args[:driver_id].is_a? Integer) && (args[:driver_id] > 0 )

      raise ArgumentError.new("Warning: Driver name not reported") unless (args[:name].is_a? String) && (args.length > 0)
    end

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
