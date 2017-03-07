require_relative 'spec_helper'

describe "Driver class" do
  it "exists" do
    george_weasley = RideShare::Driver.new #({}"George Weasley", "SARJG2FD3A7D21H18")
    george_weasley.class.must_be_kind_of Class
  end
end
