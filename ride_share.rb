require 'csv'

module RideShare; end

require_relative 'lib/driver.rb'
require_relative 'lib/trip.rb'
require_relative 'lib/rider.rb'

class InvalidRatingError < StandardError
end

class InvalidVinError < StandardError
end
