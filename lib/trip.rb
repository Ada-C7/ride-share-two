# new Trip class, subclass of RideShare
# capability to return driver_id or rider_id of trip instance (attr_readers)

# initialize trip
# take in id, driver_id, rider_id, date, rating as a hash
@id
@driver_id
@rider_id
@date
@rating

# class method: all
# for each row in CSV file read in and create an instance of trip
# return all instances of trips

# class method: trips_rode(rider_id)
# find instances of trips where rider_id matches argument
# alert user if no trips with matching rider_id is found
# return collection of trips by specific rider

# class method: trips_driven(driver_id)
# find instances of trips where driver_id matches argument
# alert user if no trips with matching rider_id is found
# return collection of trips by specific driver
