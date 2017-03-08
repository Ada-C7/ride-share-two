require 'csv'

module RideShare
  class Rider
    attr_accessor :rider_id, :name, :phone_num

    def initialize(args)
      @rider_id = args[:rider_id]
      @name = args[:name]
      @phone_num = args[:phone_num]

      raise ArgumentError.new("rider id must be an integer") unless @rider_id.class == Integer
    end


  end
end
