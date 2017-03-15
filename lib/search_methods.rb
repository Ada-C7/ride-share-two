require 'csv'
require'pry'

module RecordMagic
end
def proof_data

  raise ArgumentError.new("Warning: Bad driver ID: must be a number, but was reported as #{args[:driver_id]} data not included ") unless (args[:driver_id].is_a? Integer) && (args[:driver_id] > 0 )

  raise ArgumentError.new("Warning: Driver name not reported") unless (args[:name].is_a? String) && (args.length > 0)
end

def self.all(csv_filename)
  csv = CSV.read(csv_filename,
  { headers: true,
    header_converters: :symbol,
    converters: :all  # format Integers
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

  def self.find_records(csv_filename, var_type, id_to_find)
    x = self.all(csv_filename).find_all do |record|
      record.driver_id == id_to_find
    end

    raise ArgumentError.new("Driver # #{id_to_find} does not exist")if x.length == 0
    x
  end
end
endx
