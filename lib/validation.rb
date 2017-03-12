module Validation
  private

  def validate_int(field, field_name)
    if field.class != Integer || field < 0
      raise ArgumentError.new("Required field #{field_name} must be a non-negative integer.")
    end
    return field
  end

  def validate_int_range(field, field_name, min, max)
    valid_int = validate_int(field, field_name)
    raise ArgumentError.new("#{field_name} must be between #{min} and #{max}") if !(valid_int.between?(min, max))
    return valid_int
  end

  def validate_string(field, field_name)
    if field.class != String || field == ""
      raise ArgumentError.new("Required field #{field_name} must be a non-empty string.")
    end
    return field
  end

  def validate_string_length(field, field_name, length)
    valid_string = validate_string(field, field_name)
    raise ArgumentError.new("#{field_name} is invalid length") if valid_string.length != length
    return valid_string
  end
end
