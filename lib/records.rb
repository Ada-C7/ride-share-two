module Rideshare
  class Record

    def proof_data(type, args)
      raise ArgumentError.new("#{type.to_s.capitalize[0..-4]} # #{args[:trip_id]} removed from dataset due to missing information.") unless (args.values & [0,"", nil]).empty?
    end

    def self.add_record(args, search_var)
      self.new(args, search_var)
    rescue ArgumentError => e
      puts "#{e.message}"
    rescue VinError => e
      puts "#{e.message}"
    end

    def self.all(search_var)
      csv = CSV.read(self.csv_name,
      { headers: true,
        header_converters: :symbol,
        converters: :all  # format Integers
        })


        csv.inject([])  do |arr, row|
          row_obj = self.add_record(row.to_hash, search_var)
          # avoid adding records where argument error was raised
          row_obj ? arr.push(row_obj):arr
        end
      end

      def self.find_records(search_var, id_to_find)
        self.all(search_var).find_all do |record|
          record.id ==id_to_find
        end
      end
    end
  end
