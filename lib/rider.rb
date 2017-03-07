# INSTANCE METHODS
# trips: retrieve the list of trip instances that only this rider has taken
# drivers: retrieve the list of all previous driver instances (through the trips functionality built above)

module RideShare
  class Rider
    attr_reader :id, :name

    def initialize(params)
      validate_params(params)

      @id = params[:id]
      @name = params[:name]
      @phone_number = params[:phone_number]
      @trips ||= []
    end

    def validate_params(params)
      if [params[:id], params[:name], params[:phone_number]].include? nil
        raise ArgumentError.new("Riders must have an ID, name, and phone number.")
      end
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

    def import_trips

    end

  end
end
