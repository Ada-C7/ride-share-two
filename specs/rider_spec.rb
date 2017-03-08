require_relative "spec_helper"


describe "Rider" do
  describe "#initialize" do
    it "Takes an id, name and phone number" do
      id = "007"
      name = "James Bond"
      phone_num = "(392) 217-0777"
      rider1 = RideSharing::Rider.new(id, name, phone_num)

      rider1.must_respond_to :id
      rider1.id.must_equal id

      rider1.must_respond_to :name
      rider1.name.must_equal name

      rider1.must_respond_to :phone_num
      rider1.phone_num.must_equal phone_num
    end
  end # End of describe "#initialize"
end # End of describe "Rider"
