require 'csv'

class Driver
  attr_reader :id, :name, :vin

  def initialize(id, name, vin)
    @id = id
    @name = name
    @vin = vin
  end

  # def get_driver_info
  #   @info = []
  #
  #   data = CSV.open("../support/drivers.csv")
  #
  #   data.each do |line|
  #     @info << line
  #   end
  # end


end
