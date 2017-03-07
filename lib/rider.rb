class Rider
  attr_reader :id, :name, :phone_number

  def initialize(rider_hash)
  end

  # Retrieve the list of trip instances that only this rider has taken
  def trips
  end

  # Retrieve the list of all previous driver instances
  def drivers
  end

  # Retrieve all riders from the CSV file
  def self.all
  end

  # Find a specific rider using their numeric ID
  def self.find(rider_id)
  end
end
