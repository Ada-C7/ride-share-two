require_relative 'module'

module RideShare
  class Rider
    attr_reader :id, :name, :phone_num
    def initialize(params)
      @id = params[:rider_id].to_i
      @name = params[:name]
      @phone_num = params[:phone_num]
    end

    def self.all
      csv = CSV.open("./support/riders.csv", :headers => true, :header_converters => :symbol)
      csv.map { |row| self.new(row.to_hash) }
    end

    def all_trips(id)
      rider_trips = RideShare::Trip.rider_find(id)
      raise ArgumentError.new "Sorry, this rider has no trips" if rider_trips.length < 1
      rider_trips
    end

    def self.find(id)
      self.all.find { |account| account.id == id }
    end

    def all_drivers(id)
      all_trips(id).map { |trip| trip.driver_id }
    end

  end
end
