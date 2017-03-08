require 'csv'
# csv: CSV.foreach("../support/trips.csv", {:headers => true}) do |row|

module RideShare
  class Driver
    attr_accessor :driver_id, :name, :vin

    def initialize(driver_id, name, vin)
      raise ArgumentError.new ("Vin must be 17 characters") if vin.length != 17
      @driver_id = driver_id
      @name = name
      @vin = vin
    end

    # def self.driver_trip_instances(@driver_id) #make this a .self method to utilize in trip??
    #   #use find_driver here
    #   retrieves a list of all trips a particular driver has taken
    #   so something like matching the driver id that is in the driver csv to the driver id in the trip csv
    #
    #   since the csv outpus individual arrays of each trip with driver_id in [1] of each array,
    #   i will iterate over each array and find every matching id
    # end
    #
    #
    # def average_rating
    #   #use find driver here
    #   #use driver trip instances here
    # average rating over trip instances
    # end

    def self.all_driver_info #I believe this creates an array of hashes
      all_drivers_array = []
      CSV.read('support/drivers.csv').each do |object|
        driver_id = object[0].to_i
        name = object[1].to_s
        vin = object[2].to_s
        a_driver = RideShare::Driver.new(driver_id, name, vin)
        all_drivers_array << a_driver
      end
      # print all_drivers_array
      return all_drivers_array
    end


    def self.find_drive_trips #this should be a self method
      #should use all drivers
      #we'll have to take the user id and find/match the driver_id that was input to
      #the driver id in the trip instances.
    end

    def self.find_driver(driver_id)
      drivers = RideShare::Driver.all_driver_info
      drivers.each do |object|
        if object.driver_id == driver_id
          return object
        end
      end
          raise ArgumentError.new("Driver #{driver_id} does not exist")
    end



    def self.find(id)
      a_account = Bank::Account.all
      a_account.each do |object|
        if object.id == id
        return object
        end
      end
       raise ArgumentError.new "Account: #{id} does not exist"
    end

  end

end
  # a = RideShare::Driver.new(1240483, "allison", "098748593029sjekd")
  # RideShare::Driver.all_driver_info
  # RideShare::Driver.all_drivers


  # Each driver should:
  #
  # have an ID, name, license plate and vehicle identification number
  # Each vehicle identification number should be a specific length to ensure it is a valid vehicle identification number
  # Given a driver object, you should be able to:
  #
  # retrieve the list of trip instances that only this driver has taken
  # retrieve an average rating for that driver based on all trips taken
  # You should be able to:
  #
  # retrieve all drivers from the CSV file
  # find a specific driver using their numeric ID


  #   # driver_id,  name,   vin
  #   # 1,Bernardo Prosacco,WBWSS52P9NEYLVDE9
  #   # 2,Emory Rosenbaum,1B9WEX2R92R12900E
  #   # 3,Daryl Nitzsche,SAL6P2M2XNHC5Y656
  #   # 4,Jeromy O'Keefe DVM,L1CKRVH55W8S6S9T1
  #   # 5,Verla Marquardt,TAMLE35L3MAYRV1JD
