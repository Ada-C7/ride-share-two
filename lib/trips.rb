module RideShare
  class Trip < Loadable
    attr_reader :id, :driver_id, :rider_id, :date, :rating

    def initialize(params)
      @id = params[:trip_id].to_i
      @driver_id = params[:driver_id].to_i
      @rider_id = params[:rider_id].to_i
      @date = params[:date]
      @rating = params[:rating].to_i
      raise ArgumentError.new "The rating must be between 1 and 5" if @rating > 5 || @rating < 0
    end

    def self.all
      super('./support/trips.csv')
    end
    #refactor this stuff!
    def self.find(id)
      account = super(id)
      account = [account.id, account.driver_id, account.rider_id, account.date, account.rating]
    end

    def self.rider_find(id)
      self.all.select { |trip| trip.rider_id == id }
    end

    def self.driver_find(id)
      self.all.select { |trip| trip.driver_id == id}
    end
    #write these tomorrow:
    #retrieve the associated driver instance through the driver ID
    #retrieve the associated rider instance through the rider ID


  end
end
