
class Rider
  attr_reader :id, :name, :phone

  def initialize(rider_id,name,phone_num)
    @id = rider_id
    @name = name
    @phone = phone_num
  end

end
