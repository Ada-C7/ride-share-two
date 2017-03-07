require 'csv'
require_relative 'loadable'

module RideShare
  class Rider < Loadable
    attr_reader :id, :name, :phone_num
    def initialize(params)
      @id = params[:rider_id].to_i
      @name = params[:name]
      @phone_num = params[:phone_num]
    end
    # initialize method should take ID, name, phone numbers
    # class methods
    def self.all
      super("./support/riders.csv")
    end

    def self.find(id)
      account = super(id)
      account = [account.id, account.name, account.phone_num]
    end
    #   .all riders
    #   .find riders
    # interaction methods
    #   .find_all_trips
    #   .find_all_drivers
    #
  end
end
