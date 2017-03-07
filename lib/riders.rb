require 'csv'
module RideShare
  class Rider
    attr_reader :id, :name, :phone_number
    def initialize(params)
      @id = params[:id]
      @name = params[:name]
      @phone_number = params[:phone_number]
    end
    # initialize method should take ID, name, phone numbers
    # class methods
    def self.all
      all_riders = []
      CSV.open("./support/riders.csv", {:headers => true}).each do |line|
        all_riders << self.new({name: line[1], id: line[0].to_i, phone_number: line[2]})
      end
      all_riders
    end

    def self.find(id)
      rider = []
      self.all.each do |account|
        rider = [account.id, account.name, account.phone_number] if account.id == id
      end
      rider
    end
    #   .all riders
    #   .find riders
    # interaction methods
    #   .find_all_trips
    #   .find_all_drivers
    #
  end
end
