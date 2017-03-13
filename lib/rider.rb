module Rideshare
  class Rider
    attr_reader :rider_id, :name, :phone_num
    def initialize(args)
      proof(args)
      @id = args[:rider_id]
      @name = args[:name]
      @phone_num= args[:phone_num]
    end

  end
end
