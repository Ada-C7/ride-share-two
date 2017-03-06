require 'csv'
require_relative 'trip'

class Driver
  attr_reader :id, :name, :vin

  def initialize(driver_hash)
    @id = driver_hash[:id]
    @name = driver_hash[:name]
    @vin = driver_hash[:vin]
  end
end
