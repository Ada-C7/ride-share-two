# INSTANCE METHODS
# trips: retrieve the list of trip instances that only this rider has taken
# drivers: retrieve the list of all previous driver instances (through the trips functionality built above)

module RideShare
  class Rider
    attr_reader :id, :name

    def initialize(params)
      @id = params[:id].to_i
      @name = params[:name]
      @phone_number = params[:phone_number]
    end

    def self.all
      @@all ||= CSV.read("support/riders.csv", headers:true).map do |line|
        Rider.new(
          id: line[0].to_i,
          name: line[1],
          phone_number: line[2]
        )
      end
    end

    def self.find(target_id)
      all.find { |rider| rider.id == target_id }
    end

  end
end
