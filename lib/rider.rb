
require "csv"

class Ride_Share::Rider

  attr_reader :id, :name, :phone_number

  def initialize(args_hash)
    #csv header: rider_id,name,phone_num
    @id = args_hash[:rider_id]
    @name = args_hash[:name]
    @phone_number = args_hash[:phone_num]

  end

  def self.all
    all_riders_array = []
    #CSV.read("support/riders.csv", {:headers => true}).each do |line|
    CSV.read("support/riders.csv", {:headers => true, :header_converters => :symbol}).each do |line|

      # id = line[0].to_i
      # name = line[1]
      # num = line[2].to_i
      all_riders_array << Rider.new(line)
      # all_drivers_array << Rider.new(id: id, name: name, phone_num: num)
    end
    return all_riders_array
  end

  def self.find(rider_id)
    all.each do |rider|
      return rider if rider.id == rider_id
    end
  end

  def self.print_all
    all.each do |rider|
      puts "rider id: #{rider.id}, name: #{rider.name}, phone: #{rider.phone_number}"
    end
  end
end

# Rider.print_all
