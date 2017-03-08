require 'csv'
require 'ap'
class Rider
  attr_reader :name, :id, :phone_number
  def initialize(id, name, phone_number)
    @name = name
    @id = id
    @phone_number = phone_number
  end
  def self.all
    @riders = []
    CSV.foreach("./support/riders.csv", {:headers => true}).each do |line|
      @riders << self.new(line[0].to_i, line[1].to_s, line[2].to_s)
    end
    return @riders #this is returning the riders
  end

  def self.find(id)
    rider_find = Rider.all
    rider_find.each do |rider|
      if rider.id == id
        return rider
      end
    end
    raise ArgumentError.new "Sorry, a rider with an ID:#{id} does not exist"
  end

end
# ap Rider.find(9)
  # ap Rider.all
