module RideShare
  class Driver
    initialize method needs ID and name
      -> initialize via hash?
    .all method should read in CSV
    just like this code i copied from bank accounts
    # def self.all
    #   many_accounts = []
    #   CSV.open("./support/accounts.csv").each do |line|
    #     many_accounts << self.new(line[0].to_i, line[1].to_f)
    #   end
    #   return many_accounts
    # end
      data has one-line of header then the content
      .find_by_id method
        id numbers are a mix of numbers and letters, so must be strings
      .find_all_trips(driver ID)
        must take the input of a driver ID and return a list of trip instances for that driver.
        should use the find_by_id method above
        .average_rating
        using find_by_id again, pulling all ratings and then averaging them..here or in the rider clas?
  end
end
