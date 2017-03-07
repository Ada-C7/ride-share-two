require 'csv'
require_relative 'loadable'

module RideShare
  class Driver < Loadable

    attr_reader :name, :id

    def initialize(params)
      @name = params[:name]
      @id = params[:driver_id].to_i
    end

    def self.all
      super("./support/drivers.csv")
    end

    def self.find(id)
      account = super(id)
      account = [account.id, account.name]
    end

    def find_all_trips(id)

    end

  #     data has one-line of header then the content
  #     .find_by_id method
  #       id numbers are a mix of numbers and letters, so must be strings
  #     .find_all_trips(driver ID)
  #       must take the input of a driver ID and return a list of trip instances for that driver.
  #       should use the find_by_id method above
  #       .average_rating
  #       using find_by_id again, pulling all ratings and then averaging them..here or in the rider clas?
  end
end
