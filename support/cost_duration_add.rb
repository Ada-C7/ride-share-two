require 'csv'

table = CSV.read('/Users/adai/Documents/ada/projects/ride-share-two/support/trips.csv', {headers: true, col_sep: ","})

table.each do |row|
  row["cost"] = rand(1..10)
end

table.each do |row|
  row["duration"] = rand(1..30)
end

puts table

CSV.open("/Users/adai/Documents/ada/projects/ride-share-two/support/trips2.csv", "ab") do |csv|
  table.each do |row|
    csv << row
end
end
