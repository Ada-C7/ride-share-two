require_relative 'spec_helper'

describe "Rider class" do
  let(:riders) {RideShare::Rider.all}
  let(:rider)  {RideShare::Rider.new(31, "Ms. Enrique Kiehn", "416-848-6488 x8656")}
  describe "#initialize method" do
    it "Initializes a new rider instance from the parameter" do
      rider.must_be_instance_of RideShare::Rider
      rider.must_respond_to :rider_id
      rider.rider_id.must_equal 31
      rider.must_respond_to :name
      rider.name.must_equal "Ms. Enrique Kiehn"
      rider.must_respond_to :phone
      rider.phone.must_equal "416-848-6488 x8656"
    end

    it "raises an argument error if Rider's ID or name or   phone number are invalid" do
      proc {
        RideShare::Rider.new("1q", "Ms. Enrique Kiehn", "416-848-6488 x8656")
      }.must_raise ArgumentError
      proc {
        RideShare::Rider.new(31, 57448888, "416-848-6488 x8656")}.must_raise ArgumentError
        proc {
          RideShare::Rider.new(31, "Ms. Enrique Kiehn", 4168486488)}.must_raise ArgumentError
        end
      end

      describe "self.all method" do
        it "Retrieve all riders from the CSV file" do
          riders.must_be_instance_of Array
          riders.each { |rider| rider.must_be_instance_of RideShare::Rider }
          riders.length.must_equal 300
        end

        it "Include first instance of riders in the csv file" do
          riders.first.rider_id.must_equal 1
          riders.first.name.must_equal "Nina Hintz Sr."
          riders.first.phone.must_equal "560.815.3059"
        end

        it "Include last instance of riders in the csv file" do
          riders.last.rider_id.must_equal 300
          riders.last.name.must_equal "Miss Isom Gleason"
          riders.last.phone.must_equal "791-114-8423 x70188"
        end
      end
    end
