module RideShare
  class Trip
#     attr_reader :trip_id, :date, :rating
#     def initialize(trip_id, date, rating)
#
#       @trip_id = trip_id
#       @date = date
#       @rating = rating
#     end
#
#     describe "Trips.all" do
#       it "all rides stored in an array" do
#         all_rides = RideShare::Trip.all
#         all_rides.must_be_instance_of Array
#       end
#
#       it "The ID, name, and VIN of the first and last driver match the CSV file" do
#
#           RideShare::Driver.all.first.driver_id.must_equal 1
#           RideShare::Driver.all.first.name.must_equal "Bernardo Prosacco"
#           RideShare::Driver.all.first.vin.must_equal "WBWSS52P9NEYLVDE9"
#
#           RideShare::Driver.all.last.driver_id.must_equal 100
#           RideShare::Driver.all.last.name.must_equal "Minnie Dach"
#           RideShare::Driver.all.last.vin.must_equal "XF9Z0ST7X18WD41HT"
#
#         index = 0
#         CSV.read("./support/drivers.csv") do |each_driver|
#           driver[index].driver_id.must_equal each_driver[0].to_i
#           driver[index].name.must_equal each_driver[1].to_s
#           driver[index].vin.must_equal each_driver[2].to_s
#           index += 1
#         end
#       end
#     end
#
  end # end of Trip
end # end of module
