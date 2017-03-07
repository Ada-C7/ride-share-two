require 'csv'

module RideShare
  class Loadable

    def self.all(csv, arg)
      csv_organized = []
      CSV.open(csv, {:headers => true}).each do |line|
        csv_organized << self.new({id: line[0].to_i, name: line[1]}) if arg == "driver"
        csv_organized << self.new({id: line[0].to_i, name: line[1], phone_number: line[2]}) if arg == "rider"
        csv_organized << self.new({id: line[0].to_i, driver_id: line[1].to_i, rider_id: line[2].to_i, date: line[3], rating: line[4].to_i}) if arg == "trip"
      end
      csv_organized
    end

    def self.find(id)
      return_object = []
      self.all.each { |account|  return_object = account if account.id == id }
      return_object
    end
  end
end
