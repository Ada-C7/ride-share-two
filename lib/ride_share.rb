require 'csv'

module RideShare
  def self.validate_int(field, field_name)
    if field.class != Integer || field <= 0
      raise ArgumentError.new("Required field #{field_name} must be a positive integer.")
    end

    return field
  end

  def self.validate_string(field, field_name)
    if field.class != String || field == ""
      raise ArgumentError.new("Required field #{field_name} must be a non-empty string.")
    end
    
    return field
  end
end

require_relative 'driver'
require_relative 'rider'
require_relative 'trip'
