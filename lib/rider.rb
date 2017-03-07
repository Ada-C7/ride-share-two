require 'csv'


class Rider
  attr_reader :id, :name, :phone

  def initialize(rider_id,name,phone_num)
    @id = rider_id
    @name = name
    @phone = phone_num
  end

  def self.all
    riders = []
    CSV.foreach("./support/riders.csv", {:headers => true}) do |line|
      id = line[0]
      name = line[1]
      phone = line[2]

      riders << Rider.new(id, name, phone)

    end
    return riders
  end

  def trips
    rider_trips = []
    Trip.all.each do |trip|
      if trip.rider == @id
        rider_trips << trip
      end
    end
    return rider_trips
  end

end
