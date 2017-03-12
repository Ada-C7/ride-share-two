require 'csv'


#would not work with relative paths for file (?)
table = CSV.read('/Users/sai/Documents/ada/projects/ride-share-two/support/trips.csv', {headers: true, col_sep: ","})

table.each do |row|
  cost = rand(5.00..45.00) 
  row["cost"] = cost.round(2)
end

table.each do |row|
  row["duration"] = rand(1..45) #in minutes
end

CSV.open('/Users/sai/Documents/ada/projects/ride-share-two/support/trips.csv', 'w') do |f|
  f << table.headers
  table.each { |row| f << row }
end
