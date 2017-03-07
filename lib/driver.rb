require 'csv'

class Driver
  attr_reader :id, :name, :vin

  def initialize(id, name, vin)
    @id = id
    @name = name
    @vin = vin
  end

  def self.all
    driver_info = []

    all_driver = CSV.open("/Users/jou-jousun/ada/projects/ride-share-two/support/drivers.csv")

    all_driver.each do |driver|
      driver_info << Driver.new(driver[0].to_i, driver[1].to_s, driver[2].to_s)
    end

    return driver_info

    # get info from CSV
    # create new instances of Driver
    # push each new Driver instances into an driver_info
    # return the array
  end

  #.find(id) when you input id, it will return the driver (instance) with that id
  def self.find(id) #could use Class variable here instead of loading Accounts array each time
    Driver.all.each do |driver|
      if driver.id == id
        return driver
      end
    end
    raise ArgumentError.new "Driver doesn't exist"
  end

end
