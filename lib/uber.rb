require_relative 'data_import'

module RideShare
  class Uber

    def self.all(source_file)
      DataImport.import_attributes(source_file).map do |params|
        self.new(params)
      end
    end

    def self.find(target_id)
      all.find { |object| object.id == target_id }
    end

    private
     
    def validate_params(params, required_attributes)
      missing = required_attributes.select do |attribute|
        !params.keys.include?(attribute) || params[attribute].to_s.empty?
      end

      unless missing.empty?
        raise ArgumentError.new("Missing parameter(s): #{missing.join(", ")}")
      end
    end

  end
end
