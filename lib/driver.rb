require 'csv'

module Rideshare
  class Driver
    ALL_DRIVERS = CSV.read('../support/drivers.csv',
    headers: true,
    header_converters: :symbol,
    converters: :all)
    def initialize
    end
  end
end

p Rideshare::Driver::ALL_DRIVERS[:driver_id].length
