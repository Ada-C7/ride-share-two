module Rideshare
	class Record
		def self.all
		end

		def dog
			puts "dog"
		end
	end
end

module Rideshare

	class Driver < Record
		def initialize
		end

		def bird
			puts "bird"
		end
	end
end
