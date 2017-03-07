require 'csv'
require 'ap'

class Driver
  attr_reader :id, :name, :vin
  def initialize(id, name, vin)
    @id = id
    @name = name
    @vin = vin
  end
  # def trip
  #   return trips = []
  # end

  def self.all
    @drivers = []
    CSV.open("./support/drivers.csv").each do |line|
    @drivers << self.new(line[0].to_i, line[1].to_s, line[2].to_s)
    end
    return @drivers
  end
end

ap Driver.all
