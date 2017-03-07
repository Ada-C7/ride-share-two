require 'csv'
require_relative 'loadable'

module RideShare
  class Rider < Loadable
    attr_reader :id, :name, :phone_number
    def initialize(params)
      @id = params[:id]
      @name = params[:name]
      @phone_number = params[:phone_number]
    end
    # initialize method should take ID, name, phone numbers
    # class methods
    def self.all
      super("./support/riders.csv", "rider")
    end

    def self.find(id)
      account = super(id)
      account = [account.id, account.name, account.phone_number]
    end
    #   .all riders
    #   .find riders
    # interaction methods
    #   .find_all_trips
    #   .find_all_drivers
    #
  end
end
