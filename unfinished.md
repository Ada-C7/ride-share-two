# TO DO

## Primary Requirements

#### Driver
  - Each vehicle identification number should be a specific length to ensure it is a valid vehicle identification number
  - retrieve an average rating for that driver based on all trips taken (format data input consistently)

#### Rider

#### Trip
-   Each rating should be within an acceptable range (1-5) <--validate the ratings

## Getting Started
You should have **95% code coverage** using simplecov.


### Optional Requirements
- The first optional should always be looking for improvements within the existing code you have already written. Are there any additional edge cases you might be missing in your tests? Any opportunity to use an enumerable method where you're using an each?
- Enhance the trip functionality to include support for cost and duration
  - Update your CSV file accordingly
- For a given rider, add the ability to return the total amount of money they have spent on all trips
- For a given rider, add the ability to return the total amount of time they have spent on their trips
- For a given driver, calculate their total revenue for all trips. Each driver gets 80% of the trip cost _after_ a fee of $1.65 is subtracted.
