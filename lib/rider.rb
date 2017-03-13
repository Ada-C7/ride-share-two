require "csv"

module RideSharing
  class Rider
    attr_reader :id, :name, :phone_num
    def initialize(rider_hash)
      raise ArgumentError.new("The input for :rider_id must be an integer > 0.\nThis driver will not be recorded.") if  rider_hash[:rider_id].class != Integer || rider_hash[:rider_id] < 1
      raise ArgumentError.new("The input for :name must be a string of at least 1 readable characters.\nThis driver will not be recorded.") if  rider_hash[:name].class != String || rider_hash[:name].delete(" ").length < 3
      # raise ArgumentError.new("The input for :phone_num must be in accordance with North Americas Numbering Plan.\nThis driver will not be recorded." ) if rider_hash[:phone_num].class != String || !(rider_hash[:phone_num].gsub(/(x.*)/, "").gsub(/[^\d]/, "").gsub(/^1/, "").length == 10)
      raise ArgumentError.new("The input for :phone_num must be in accordance with North Americas Numbering Plan.\nThis driver will not be recorded." ) if rider_hash[:phone_num].class != String || self.class.invalid_phone_num?(rider_hash[:phone_num])
      @id = rider_hash[:rider_id]
      @name = rider_hash[:name]
      @phone_num = rider_hash[:phone_num]
    end

    # def initialize(id, name, phone_num)
    #   @id = id
    #   @name = name
    #   @phone_num = phone_num
    # end

    def self.all(path = "./support/riders.csv")
      all_riders = []
      CSV.foreach(path, :headers => true, :header_converters => :symbol) do |row|
        begin
          raise ArgumentError.new("The rider_id \"#{row[0]}\" creates an invalid id number. The id number must be an integer > 0.\nHence this driver will not be recorded." ) if row[0] == nil || row[0].to_i < 1
        rescue ArgumentError => exception
          puts "#{exception.message}"
          next
        end

        begin
          raise ArgumentError.new("The input name for rider_id #{row[0]} must be at least 1 readable character long.\nHence this driver will not be recorded." ) if row[1] == nil || row[1].delete(" ").length < 3
        rescue ArgumentError => exception
          puts "#{exception.message}"
          next
        end


        begin
          # raise ArgumentError.new("The phone_num is not valid for rider_id #{row[0]}. It must be in accordance with North Americas Numbering Plan.\nHence this driver will not be recorded." ) if row[2] == nil || !(row[2].gsub(/(x.*)/, "").gsub(/[^\d]/, "").gsub(/^1/, "").length == 10)
          raise ArgumentError.new("The phone_num is not valid for rider_id #{row[0]}. It must be in accordance with North Americas Numbering Plan.\nHence this driver will not be recorded." ) if row[2] == nil || invalid_phone_num?(row[2])
        rescue ArgumentError => exception
          puts "#{exception.message}"
          next
        end

        rider_hash = row.to_hash
        rider_hash[:rider_id] = rider_hash[:rider_id].to_i
        all_riders << self.new(rider_hash)
      end
      return all_riders
    end

    # def self.all(path = "./support/riders.csv")
    #   all_riders =[]
    #   CSV.foreach(path, {:headers => true}) do |line_array|
    #     all_riders << self.new(line_array[0].to_i, line_array[1], line_array[2])
    #   end
    #   return all_riders
    # end

    def self.find(rider_id)
      # found_rider = self.all.select { |rider| rider.id == rider_id}
      # raise ArgumentError.new("No such id number exist") if found_rider == []
      # return found_rider.first

      found_rider = self.all.select { |rider| rider.id == rider_id}
      begin
        raise ArgumentError.new("Id number #{rider_id} does not exist") if found_rider == []
      rescue ArgumentError => exception
        puts "#{exception.message}"
      end
      return found_rider.first
    end

    def list_of_trips
      RideSharing::Trip.find_all_trips_for_rider(@id)
    end

    def previous_drivers
      drivers = list_of_trips.map { |trip| trip.find_driver}.delete_if {|driver| driver == nil}.uniq { |driver| driver.id}
      return drivers
    end

    private
#### Private section
    def self.invalid_phone_num?(number)

      # number.gsub(/(x.*)/, "").gsub(/[^\d]/, "").gsub(/^1/, "").length == 10 ? invalid_number = false : invalid_number = true

      numbers_wo_extension = number.gsub(/(x.*)/, "").gsub(/[^\d]/, "")
      if numbers_wo_extension.length > 11 || numbers_wo_extension.length < 10
        invalid_number = true
      elsif numbers_wo_extension.length == 11
        numbers_wo_extension = numbers_wo_extension.gsub(/^1/, "")
        if numbers_wo_extension.length == 11
          invalid_number = true
        end
      end

      if numbers_wo_extension.length == 10
          # /[2-9][0-9][0-9][2-9][0-9][0-9][0-9][0-9][0-9][0-9]/ === numbers_wo_extension ? invalid_number = false : invalid_number = true
          /[2-9][0-9][0-9][2-9]([02-9][0-9]|[1][02-9])[0-9][0-9][0-9][0-9]/  === numbers_wo_extension ? invalid_number = false : invalid_number = true
      end
      return invalid_number
    end


  end # End of class Rider
end # End of module RideSharing
