require 'csv'

class Rider
  attr_reader :id, :name, :phone

  def initialize(id, name, phone)
    @id = id
    @name = name
    @phone = phone
  end

  def self.all
    rider_info = []

    CSV.foreach("/Users/jou-jousun/ada/projects/ride-share-two/support/riders.csv", {:headers => true}) do |rider|
      rider_info << Rider.new(rider[0].to_i, rider[1].to_s, rider[2].to_s)
    end

    return rider_info
  end

  def self.find(id)
    Rider.all.each do |rider|
      if rider.id == id
        return rider
      end
    end
    raise ArgumentError.new "Rider doesn't exist"
  end

  def trips(id)
    Trip.find_all_for_rider(id)
  end

  def previous_drivers(id)
    # all_trips = Trip.find_all_for_rider(id)
    all_trips = trips(id)
    previous_drivers_by_id = []
    all_trips.each { |trip| previous_drivers_by_id << trip.driver_id }
    # now, an array of driver_ids
    rider_previous_drivers = []
    previous_drivers_by_id.each { |driver_id| rider_previous_drivers << Driver.find(driver_id) }
    return rider_previous_drivers
  end
end
