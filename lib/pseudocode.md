
module rideshare

  driver class

    define method init
      initialize with driver id, name, and vin

    define method for getting driver's trips
      find in the trips method all trips containing driver id
      execute the trips.all
      return array with trip instances back

    define method for all
      read CSV file
      create new instances

    define method to find one driver with driver id
      search in all for driver ID
      return driver instances

    define method for rating given driver id
      search all trips for driver id
      return all ratings for driver
      average ratings with array length
