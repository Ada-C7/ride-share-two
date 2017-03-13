require 'csv'

module RideShare
  class Trip
    attr_reader :id_t, :id_d, :id_r, :date, :rating

    def initialize(id_t, id_d, id_r, date, rating)
      raise ArgumentError.new('Trip id no valid') if id_t.class != Integer
      raise ArgumentError.new('Trip id no valid') if id_t < 0
      raise ArgumentError.new('Driver id no valid') if id_d.class != Integer
      raise ArgumentError.new('Driver id no valid') if id_d < 0
      raise ArgumentError.new('Rider id no valid') if id_r.class != Integer
      raise ArgumentError.new('Rider id no valid') if id_r < 0
      raise ArgumentError.new('Date must be a string') if date.class != String
      if rating < 1 || rating > 5
        raise ArgumentError.new('Rate should be between 1 and 5 points')
      end

      @id_t = id_t
      @id_d = id_d
      @id_r = id_r
      @date = date
      @rating = rating
    end

    def self.all
      info = []
      CSV.open("support/trips.csv", :headers => true).each do |line|
        info << self.new(line[0].to_i, line[1].to_i, line[2].to_i, line[3].to_s,
        line[4].to_f)
      end
      info
    end

    def self.trips_made_by_driver(id_d)
      raise ArgumentError.new('Driver ID no valid') if id_d < 0
      raise ArgumentError.new('Driver ID no valid') if id_d.class != Integer
      trips = []
      all.each do |line|
        if line.id_d == id_d
          trips << line
        end
      end
      trips
    end

    def self.trips_taken_by_rider(id_r)
      raise ArgumentError.new('Rider ID no valid') if id_r < 0
      raise ArgumentError.new('Rider ID no valid') if id_r.class != Integer
      trips = []
      # all.map {|line| line}
      trips = []
      all.each do |line|
        if line.id_r == id_r
          trips << line
        end
      end
      trips
    end

    def driver
      RideShare::Driver.find_driver(@id_d)
    end

    def rider
      return RideShare::Rider.find_rider(@id_r)
    end

  end#end of Trip class
end#end of the module RideShare
