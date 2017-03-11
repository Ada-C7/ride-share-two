require 'csv'

CSV.parse('./support/trips.csv') do |row|

CSV.open('./support/trips.csv', 'wb', :write_headers=> true, :headers => ["cost", "duration"]) do |csv|
  601.times do |num|
    cost = rand(1..50)
    duration = rand(1..60)
    data_push = [cost, duration]
    csv << data_push
  end
end
