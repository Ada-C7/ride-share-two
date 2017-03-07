module RideShare

  class Rider
    attr_reader :id, :name, :phone

    def initialize(id, name, phone)
      @id = id
      @name = name
      @phone = phone

    end

    def all
      all_riders = []

      csv_data = CSV.read("support/riders.csv")

      csv_data.each do |line|
        all_riders << Rider.new(line[0].to_i, line[1].to_s, line[2])
      end
      return all_riders
    end

    def find
      
    end

  end

end
