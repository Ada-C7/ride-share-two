require 'csv'
require'pry'

module RecordMagic
  def proof_data

    raise ArgumentError.new("Warning: Bad driver ID: must be a number, but was reported as #{args[:driver_id]} data not included ") unless (args[:driver_id].is_a? Integer) && (args[:driver_id] > 0 )

    raise ArgumentError.new("Warning: Driver name not reported") unless (args[:name].is_a? String) && (args.length > 0)
  end

  def all(csv_filename,search_var)
    csv = CSV.read(csv_filename,
    { headers: true,
      header_converters: :symbol,
      converters: :all  # format Integers
      })

      csv.map do |row|
        args = row.to_hash
        begin
          self.new(args,search_var)
        rescue
          #if I had time I would make an error log here
        end
      end
    end

    def find_records(csv_filename, search_var, id_to_find)
      fail = proc {
        raise ArgumentError.new("#{search_var.to_s} # #{id_to_find}. Does not exist")
      }
      self.all(csv_filename,search_var).find(fail) do |record|
        record.remove_instance_variable(:@id) == id_to_find

      end
    end
  end
