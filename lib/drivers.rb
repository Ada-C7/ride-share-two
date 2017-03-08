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

    #refactor this
    def all_trips(id)
      RideShare::Trip.driver_find(id)
    end

    def average_rating(id)
      (all_trips(id).sum { |trip| trip.rating } / all_trips(id).length.to_f).round(2)
    end
  end
end

ron = RideShare::Driver.new({name: "Ron Weasley", driver_id: 1})
