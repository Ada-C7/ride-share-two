
module RideShare

  class Rider
    attr_reader :id, :name, :phone_num

    def initialize(id, name, phone_num)
      @id = id
      @name = name
      @phone_num = phone_num
    end


    def self.all
      riders_array = []
      CSV.read("support/riders.csv", {:headers => true}).each do |rider|
        riders_array << (Rider.new(rider[0], rider[1], rider[2]))
      end
      riders_array
    end

    def self.find(id)

    end


  end
end
