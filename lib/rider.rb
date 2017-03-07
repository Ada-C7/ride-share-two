module RideShare

  class Rider < User

    attr_accessor :phone_numb

    def initilize(id, name, phone_num)
      super(id , name)
      @phone_num = phone_num

    end

    def self.all
        CSV.foreach("../support/drivers.csv", {:headers => true}) do |row|
        @id = row[0].to_i
        @name = row[1]
        @phone_num = row[2]
        rider = RideShare::Rider.new(id, name, phone_num)
        riders << rider
    end






  end # class


end #module
