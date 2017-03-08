require 'csv'

  class Rider
    attr_reader :id, :name, :phone

    def initialize(id, name, phone)
      @id = id
      @name = name
      @phone = phone

    end

    def self.all
      all_riders = []
#
      csv_data = CSV.read("support/riders.csv")
      csv_data.shift

      csv_data.each do |line|
        all_riders << Rider.new(line[0].to_i, line[1].to_s, line[2])
      end
      return all_riders
    end

    def self.find(id)
      riders = Rider.all
      return riders.find {|rider| rider.id == id }
    end

    def to_s
      "id: #{ @id }, name: #{ @name }, phone: #{ @phone }"
    end
  end
