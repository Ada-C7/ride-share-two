require_relative 'spec_helper'

describe "Driver Class" do

  it "Instantiates a new instance of Driver class" do
    bob = Driver.new
    bob.must_be_instance_of Driver
  end


end
