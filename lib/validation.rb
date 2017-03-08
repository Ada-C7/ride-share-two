module Validation

  def validate_int(field, field_name)
    if field.class != Integer || field < 0
      raise ArgumentError.new("Required field #{field_name} must be a non-negative integer.")
    end

    return field
  end

  def validate_string(field, field_name)
    if field.class != String || field == ""
      raise ArgumentError.new("Required field #{field_name} must be a non-empty string.")
    end

    return field
  end
end
