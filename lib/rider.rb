require 'csv'
require_relative 'trip'

class Rider
  attr_reader :id, :name, :phone

  def initialize(rider_hash)
    @id = rider_hash[:id]
    @name = rider_hash[:name]
    @phone = rider_hash[:phone]
  end
end
