require 'csv'
require_relative 'uber'

table = CSV.read("support/trips.csv", headers: true)

table.each do |row|
  duration = rand(1..30)
  distance = (duration * 0.58).round(2) # assuming 35 mph

  row["duration"] = duration
  row["distance"] = distance
  row["fare"] = RideShare::Uber.fare(duration, distance)
end

CSV.open("support/trips_with_cost.csv", "w") do |f|
  f << table.headers
  table.each{|row| f << row}
end
