module Rideshare
  class Rider
    attr_reader :rider_id, :name, :phone_num

    def initialize(args)

      proof(args)

      @rider_id = args[:rider_id]
      @name = args[:name]
      @phone_num= args[:phone_num]
    end

    private

    def proof(args)

      raise ArgumentError.new("Warning: Bad rider ID: must be a number, but was reported as #{args[:rider_id]} data not included ") unless (args[:rider_id].is_a? Integer) && (args[:rider_id] > 0 )

      raise ArgumentError.new("Warning: Rider name not reported") unless (args[:name].is_a? String) && (args[:name].length > 0)
    end

    # returns a collection of Driver instances, representing all of the drivers described in drivers.csv
    def self.all(csv_filename)
      #formats numbers properly
      CSV.read(csv_filename).to_a[1..-1].map do |row|
        args = { rider_id: row[0].to_i, name: row[1], phone_num: row[2],  }
        begin
          self.new(args)
        rescue
          # if I had time, I would make class ErrorLogger to log the errors
        end
      end
    end

    def self.find_rider(csv_filename, id_to_find)
      fail = proc {
        raise ArgumentError.new("There is no rider with id #{id_to_find}.")
      }
      self.all(csv_filename).find(fail) do |rider|
        rider.rider_id == id_to_find
      end
    end
  end
end
