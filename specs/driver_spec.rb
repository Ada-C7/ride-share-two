require_relative 'spec_helper'
describe "Driver" do
  describe "initialize" do
    let(:ok_driver) {Rideshare::Driver.new(driver_id: 1, name: "Margerie Stewart-Baxter", vin: "12345678901234567")}

    let(:bad_vin_2short) {
      proc{
        Rideshare::Driver.new(driver_id: 1, name: "Hubert Cumberdale", vin: "1234567890123456")
      }
    }

    let(:bad_vin_2long) {
      proc {
        Rideshare::Driver.new(driver_id: 1, name: "Jeremy Fisher", vin: "123456789012345678")
      }
    }

    let(:bad_id) {
      proc{
        Rideshare::Driver.new(driver_id: 'b', name: "Hubert Cumberdale", vin: "12345678901234567")}
      }

      let(:no_name) {
        proc{Rideshare::Driver.new(name: "Ralph Waldo Emerson", name: "", vin: "12345678901234567")}
      }


      it "has a driver id, a name of the right types" do
        ok_driver.driver_id.must_be_kind_of Integer
        ok_driver.vin.must_be_kind_of String
        ok_driver.vin.must_be_kind_of String
      end

      it "raises an argument error if vin isn't right length" do
        bad_vin_2short.must_raise ArgumentError
        bad_vin_2long.must_raise ArgumentError
      end

      it "raises an argument error if driver_id is not an integer " do
        bad_id.must_raise ArgumentError
      end

      it "raises an argument error if name is not entered" do
        no_name.must_raise ArgumentError
      end
    end


    describe "self.all" do
      let(:all_drivers) {Rideshare::Driver.all("support/drivers.csv")}

      it "returns a collection with right number of rows" do
        all_drivers.length.must_equal 100
      end

      it "has returns values of the correct class (and no nil values)" do
        all_drivers.each do |driver|
          driver.driver_id.must_be_kind_of Integer
          driver.vin.must_be_kind_of String
          driver.name.must_be_kind_of String
        end
      end

      it 'has a test value from the csv' do
        all_drivers[3].name.must_equal "Jeromy O'Keefe DVM"
      end
    end

    describe "find_driver" do
      let(:found_driver) {Rideshare::Driver.find_driver('support/drivers.csv', 4)}

      let(:imaginary_driver) {
        proc {Rideshare::Driver.find_driver('support/drivers.csv', 500)}
      }


      it "finds a specific driver using their numeric ID" do
        found_driver.name.must_equal "Jeromy O'Keefe DVM"
        found_driver.vin.must_equal "L1CKRVH55W8S6S9T1"
      end

      it "returns an error if the driver doesn't exist" do
        imaginary_driver.must_raise ArgumentError
      end
    end


    describe "get_driver_rating" do
      it "retrieves an average rating for that driver based on all trips taken" do
      end
    end

    describe "subset_driver_trips" do
      it "retrieves all the trip instances that the driver has taken" do
      end
    end
  end
