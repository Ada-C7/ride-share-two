require 'csv'

class Trip
  attr_reader :id, :driver_id, :rider_id

  def initialize(id, rider_id, driver_id, date, rating)
    @id = id
    @rider_id = rider_id
    @driver_id = driver_id
    @date = date
    @rating = rating
  end
end
