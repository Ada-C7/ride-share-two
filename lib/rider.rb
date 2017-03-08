require "csv"

module RideSharing
  class Rider
    attr_reader :id, :name, :phone_num
    def initialize(id, name, phone_num)
      @id = id
      @name = name
      @phone_num = phone_num
    end

  end # End of class Rider
end # End of module RideSharing
