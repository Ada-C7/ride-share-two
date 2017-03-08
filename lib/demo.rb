
require 'csv'

driver = []
CSV.read("../support/drivers.csv").each do |line|
  driver.push(line[0],line[1],line[2])
end

puts driver.class
