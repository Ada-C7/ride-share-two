require_relative 'module'

module RideShare
  class Driver

    attr_reader :name, :id

    def initialize(params)
      @name = params[:name]
      @id = params[:driver_id].to_i
    end

    def self.all
      csv = CSV.open("./support/drivers.csv", :headers => true, :header_converters => :symbol)
      csv.map { |row| self.new(row.to_hash) }
    end

    def self.find(id)
      self.all.find { |account| account.id == id }
    end

    def all_trips(id)
      driver_trips = RideShare::Trip.driver_find(id)
      raise ArgumentError.new "Sorry, this driver has no trips" if driver_trips.length < 1
      driver_trips
    end

    def average_rating(id)
      (all_trips(id).sum { |trip| trip.rating } / all_trips(id).length.to_f).round(2)
    end
  end
end
