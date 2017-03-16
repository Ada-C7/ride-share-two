require_relative 'spec_helper'

describe "Driver" do
  describe "initialize" do
    let(:ok_driver) {Rideshare::Driver.new( { driver_id: 1, name: "OK Driver", vin: "1234567890123456B" }, :driver_id )}

    let(:bad_vin_2short) {
      proc{
        Rideshare::Driver.new({driver_id: 1, name: "Ms.. Long Vin", vin: "123456789012345B"}, :driver_id)
      }
    }

    let(:bad_vin_2long) {
      proc {
        Rideshare::Driver.new({driver_id: 1, name: "Ms.. Long Vin", vin: "12345678901234567B"}, :driver_id)
      }
    }

    let(:bad_id) {
      proc{
        Rideshare::Driver.new({id: 'b', name: "Miss No ID", vin: "12345678901234567"}, :driver_id)}
      }

      let(:no_name) {
        proc{Rideshare::Driver.new({name: "", vin: "12345678901234567"}, :driver_id)}
      }

      it "has a driver id, a name of the right types" do
        ok_driver.driver_id.must_be_kind_of Integer
        ok_driver.vin.must_be_kind_of String
        ok_driver.name.must_be_kind_of String
      end

      it "gives a warning if the vin isn't right" do
        bad_vin_2short.must_raise ArgumentError
        bad_vin_2long.must_raise ArgumentError
      end


      it "raises an argument error if name is not entered" do
        no_name.must_raise ArgumentError
      end
    end


    describe "all" do
      let(:all_drivers) {Rideshare::Driver.all("support/drivers.csv")}

      it "returns a collection with right number of rows" do
        all_drivers.length.must_equal 100
      end

        it "has returns values of the correct class (and no nil values)" do
          all_drivers.each do |driver|
            driver.must_be_kind_of Rideshare::Driver
            driver.driver_id.must_be_kind_of Integer
            driver.vin.must_be_kind_of String
            driver.name.must_be_kind_of String
          end
        end

        it 'has a test value from the csv' do
          all_drivers[3].name.must_equal "Jeromy O'Keefe DVM"
        end
    end
    #
    # describe "find_driver" do
    #   let(:found_driver) {Rideshare::Driver.find_records('support/drivers.csv', 4)}
    #
    #   let(:imaginary_driver) {
    #     proc {Rideshare::Driver.find_records('support/drivers.csv', 500)}
    #   }
    #
    #   let(:double_driver) {Rideshare::Driver.find_records('support/double_drivers.csv', 94)}
    #
    #
    #   it "finds a spec`ific driver using their numeric ID" do
    #     found_driver[0].name.must_equal "Jeromy O'Keefe DVM"
    #     found_driver[0].vin.must_equal "L1CKRVH55W8S6S9T1"
    #   end
    #
    #   it "returns an error if the driver doesn't exist" do
    #     imaginary_driver.must_raise ArgumentError
    #   end
    #
    #   it "returns an error if two drivers have the same id" do
    #     double_driver.must_raise ArgumentError
    #
    #   end
    # end
    #
    #
    # describe "subset_driver_trips" do
    #   it "retrieves all the trip instances that the driver has taken" do
    #   end
    # end

    #
    # describe "get_driver_rating" do
    #   it "retrieves an average rating for that driver based on all trips taken" do
    #   end
    # end


  end
