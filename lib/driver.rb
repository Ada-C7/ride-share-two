require 'csv'
require 'pry'

class Driver
  attr_reader :id, :name, :vin

  def initialize(id, name, vin)
    @id = id
    @name = name
    raise ArgumentError.new("vin must be 17 characters") if vin.length != 17
    @vin = vin
  end

  def self.all
    drivers = []
    # binding.pry
    CSV.foreach("./support/drivers.csv", {:headers => true}).each do |line|
      id = line[0]
      name = line[1]
      vin = line[2]

      drivers << Driver.new(id, name, vin)
    end
    return drivers
  end

end
