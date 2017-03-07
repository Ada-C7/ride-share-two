require 'csv'
require 'ap'
class Rider
  attr_reader :name, :id, :phone_number
  def initialize(name, id, phone_number)
    @name = name
    @id = id
    @phone_number = phone_number
  end
  def self.all
    @riders = []
    CSV.open("./support/riders.csv").each do |line|
    @riders << self.new(line[0].to_i, line[1].to_s, line[2].to_s)
    end
    return @riders #this is returning the riders
  end
end

ap Rider.all
