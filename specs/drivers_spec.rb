require_relative 'spec_helper'

describe "Driver class" do
  let(:driver) { RideShare::Driver.new({name: "Ron Weasley", id: "SARJG2FD3A7D21H18"})}
  it "exists" do
    driver.class.must_be_kind_of Class
  end

  it "initializes with an ID and name" do
    skip
    driver.must_respond_to :id
    driver.id.must_equal "SARJG2FD3A7D21H18"

    driver.must_respond_to :name
    driver.name.must_equal "Ron Weasley"
  end

  it "returns a list of drivers and IDs of the correct length when you call .all" do
    skip
    driver.all.length == CSV.read("./support/drivers.csv").length
  end

  it "can return the first driver from the CSV" do
    skip
    driver.find("WBWSS52P9NEYLVDE9").must_equal ["Bernardo Prosacco","WBWSS52P9NEYLVDE9"]
  end

  it " can return the last driver from the CSV" do
    skip
    driver.find("XF9Z0ST7X18WD41HT").must_equal ["Minnie Dach","XF9Z0ST7X18WD41HT"]
  end

  it "can find all a single driver's trips" do
    skip

  end

  it "can find  a single driver's average rating" do
    skip

  end
end
