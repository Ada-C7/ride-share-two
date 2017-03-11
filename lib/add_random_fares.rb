require "csv"
table = CSV.read("support/trips.csv", headers: true)

# Fare Calculation Details for Seattle
# Base Fare         $1.35
# Per Minute        $0.24
# Per Mile          $1.35
# Booking Fee       $1.65
# Minimum Fare      $5.15

def fare(duration, distance)
  fare = 1.35 + 1.65 + (duration*0.24) + (distance*1.35)
  [5.15,fare.round(2)].max
end

table.each do |row|
  duration = rand(1..30)
  distance = (duration * 0.58).round(2)

  row["duration"] = duration
  row["distance"] = distance
  row["fare"] = fare(duration, distance)
end

# write to file
CSV.open("support/trips_with_cost.csv", "w") do |f|
  f << table.headers
  table.each{|row| f << row}
end
