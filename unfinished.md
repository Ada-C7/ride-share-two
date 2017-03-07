# TO DO

## Primary Requirements

#### Driver
  - Each vehicle identification number should be a specific length to ensure it is a valid vehicle identification number

Given a driver object, you should be able to:
- retrieve the list of trip instances that only this driver has taken
- retrieve an average rating for that driver based on all trips taken

#### Rider

Given a rider object, you should be able to:
- retrieve the list of trip instances that only this rider has taken
- retrieve the list of all previous driver instances (through the trips functionality built above)

#### Trip
-   Each rating should be within an acceptable range (1-5)

You should be able to:
- find all trip instances for a given driver ID
- find all trip instances for a given rider ID
- retrieve all trips from the CSV file

## Getting Started
You will run tests by executing the `rake` command, as configured in a Rakefile. You should have **95% code coverage** using simplecov.

### Process
You should use the following process as much as possible:  

1. Write pseudocode
1. Write test(s)
1. Write code

### Optional Requirements
- The first optional should always be looking for improvements within the existing code you have already written. Are there any additional edge cases you might be missing in your tests? Any opportunity to use an enumerable method where you're using an each?
- Enhance the trip functionality to include support for cost and duration
  - Update your CSV file accordingly
- For a given rider, add the ability to return the total amount of money they have spent on all trips
- For a given rider, add the ability to return the total amount of time they have spent on their trips
- For a given driver, calculate their total revenue for all trips. Each driver gets 80% of the trip cost _after_ a fee of $1.65 is subtracted.
