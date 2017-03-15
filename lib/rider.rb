module Rideshare
  class Rider
    def initialize(args)
      proof(args)
      @id = args[:varname]
      @rider_id = args[:rider_id]
      @name = args[:name]
      @phone_num= args[:phone_num]
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

    end
  end
  #   class Rider
  #     extend RecordMagic
  #     attr_reader :rider_id, :name, :phone_num, :id
  #     def initialize(args)
  #       proof(args)
  #       @id = args[:varname]
  #       @rider_id = args[:rider_id]
  #       @name = args[:name]
  #       @phone_num= args[:phone_num]
  #     end
  #
  #     def self.trips_for_rider(id_to_find)
  #       Trip.get_trips_by_var(id_to_find, :rider_id)
  #       binding.pry
  #     end
  #
  #     def self.was_driven_by(rider_id)
  #       driver_ids = trips_for_rider(rider_id).map {|x| x.driver_id}.uniq
  #       Driver.get_driver_instance(driver_ids)
  #     end
  #   end
  # end
