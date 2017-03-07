require 'csv'
module RideShare
  class Rider
    attr_reader :id, :name, :phone_number

    def initialize(info)
      @id = info[:id]
      @name = info[:name]
      @phone_number = info[:phone_number]
    end

    def self.all(csv_file)
      riders = CSV.read(csv_file)
      riders.shift
      riders.map! do |rider_info|
        rider = Hash.new
        rider[:id] = rider_info[0].to_i
        rider[:name] = rider_info[1]
        rider[:phone_number] = rider_info[2]
        rider_info = rider
      end

      riders.map! { |info| self.new(info) }
      return riders
    end
  end
end
