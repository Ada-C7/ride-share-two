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

  end
end
