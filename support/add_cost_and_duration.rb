require 'csv'
prng = Random.new

costs = []
601.times do
  costs << prng.rand(20.01).round(2).to_f
end

# puts costs

my_file = CSV.foreach("support/trips_plus.csv", "r") do |row|
  costs.each do |cost|
    row << cost
  end
end
 puts my_file


# my_file.each do |line|
#   line << "#{prng.rand(24).to_s.rjust(2, '0')}:#{prng.rand(60).to_s.rjust(2,'0')}:#{prng.rand(60).to_s.rjust(2,'0')}"
# end
#
# puts my_file

# CSV.open("path/to/new_trips.csv", "wb") do |csv|
#   my_file.each do |line|
#     csv << line
#   end
# end
