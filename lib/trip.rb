require 'csv'
require 'time'
require 'pry'
require_relative 'rider'
require_relative 'driver'

module RideShare
  class Trip
    attr_reader :id_t, :id_d, :id_r, :date, :rating

    def initialize(id_t, id_d, id_r, date, rating)
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
      # CSV.open("../support/trips.csv", :headers => true).each do |line|
      CSV.open("support/trips.csv", :headers => true).each do |line|
        info << self.new(line[0].to_i, line[1].to_i, line[2].to_i,
        Date.parse(line[3]), line[4].to_f)
      end
      info
    end


    def self.trips_made_by_driver(id_d)
      trips = []
      all.each do |line|
        if line.id_d == id_d
          trips << line
        end
      end
      trips
    end

    def self.trips_taken_by_rider(id_r)
      trips = []
      all.each do |line|
        if line.id_r == id_r
          trips << line
        end
      end
      trips
    end


  end#end of Trip class
end#end of the module RideShare
