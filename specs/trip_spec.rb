# TODO: Make sure array is picking values correctly.

require_relative 'spec_helper.rb'

describe "retrieve an array from self.all" do
  before do
    # TODO: update to let()
    @trip = RideShare::Trip.all
  end
  it "retrieve an array" do
    @trip.must_be_instance_of Array
  end

  it "retrieves the trip_id, driver_id, rider_id, date, and rating" do
    CSV.read('support/drivers.csv') do |line|
      counter = 0

      @trip[counter][0].trip_id.must_equal line[counter][0].to_i
      @trip[counter][1].driver_id.must_equal line[counter][1].to_i
      @trip[counter][2].rider_id.must_equal line[counter][2].to_i
      @trip[counter][3].date.must_equal line[counter][3].to_s
      @trip[counter][4].rating.must_equal[counter][4].to_i
    end
  end
end
