require 'csv'

class Rider
  attr_reader :id

  def initialize(id, name, phone_num)
    @id = id
    @name = name
    @phone_num = phone_num
  end
end
