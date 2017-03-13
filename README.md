
Heya!
# Ride Share
Remember the ride share exercise we did with designing and creating a system to track the ride share data from a CSV file? We did a lot of great work on this exercise in creating arrays and hashes of data, but we've learned a lot since we did that exercise!

Now, we're going to use our understanding of classes, methods and attributes to create an object-oriented implementation of our ride share system.

## Learning Goals
Reinforce and practice all of the Ruby and programming concepts we've covered in class so far:
- Creating and instantiating classes with attributes
- Creating class and instance methods within our classes
- Writing pseudocode and creating tests to drive the creation of our code
- Importing data from a CSV file

## Primary Requirements
Create a system that will manage information related to ride sharing. The system should have a way to keep track of drivers, riders and the trips that the drivers take with their riders.


#### Driver
Each driver should:
- have an ID, name and vehicle identification number
  - Each vehicle identification number should be a specific length to ensure it is a valid vehicle identification number

Given a driver object, you should be able to:
- retrieve the list of trip instances that only this driver has taken
- retrieve an average rating for that driver based on all trips taken

You should be able to:
- retrieve all drivers from the CSV file
- find a specific driver using their numeric ID

#### Rider
Each rider should:
- have an ID, name and phone number

Given a rider object, you should be able to:
- retrieve the list of trip instances that only this rider has taken
- retrieve the list of all previous driver instances (through the trips functionality built above)

You should be able to:
- retrieve all riders from the CSV file
- find a specific rider using their numeric ID

#### Trip
Each trip should:
- have an ID, rider ID, a driver ID, date, rating
-   Each rating should be within an acceptable range (1-5)

Given a trip object, you should be able to:
- retrieve the associated driver instance through the driver ID
- retrieve the associated rider instance through the rider ID

You should be able to:
- find all trip instances for a given driver ID
- find all trip instances for a given rider ID
- retrieve all trips from the CSV file

## Getting Started
This is a level 3, individual project.

We will use the same project structure we used for the previous project. Classes should be in files in the `lib` folder, and tests should be in files in the `specs` folder. You should utilize a spec helper file. You will run tests by executing the `rake` command, as configured in a Rakefile. You should have **95% code coverage** using simplecov.

The `support` folder contains CSV files which will drive your system design. Each CSV corresponds to a different type of object _as well as_ creating a relationship between different objects.

## Baseline
### Discussion
#### Phase 1
Let's start by **individually** creating the list of nouns and verbs that you would utilize to describe this problem.

After a few minutes, then you'll get together with your seat squad to discuss the nouns and verbs you came up with.

#### Phase 2
Use your list of nouns to begin thinking about what classes you will want to use. Use your list of verbs associated with nouns to consider what methods you need to put in which classes.

After a few minutes, then you'll get together with your seat squad to discuss the classes and methods you came up with.

#### Phase 3
Create a diagram that describes how each of these classes and methods (messages) will interact with one another as well as the CSV files.

### Setup
**1. Fork this repository in GitHub**
**1. Clone the repository to your computer**
**1. Create/copy a rakefile to run your tests**
**1. Open the `specs/spec_helper.rb` file to load your classes and start up simple coverage.  This file will load all the required gems and source files your spec files need so they only need to require the helper.  
  - Each of your spec files should `require_relative` the spec helper file.**
**1. Create a test to check the instantiation of one of your object types (**RED**)
**1. Create the class for the object tested in the step above (**GREEN**)
**1. Use git add, commit and push commands to push your initial code to GitHub**

### Process
You should use the following process as much as possible:  

1. Write pseudocode
1. Write test(s)
1. Write code

Since this is the **last** Ruby-only project we are doing, and a level 3, the requirements are larger than previous projects. It is possible you will not be able to complete all requirements, but if you use the process above, you will still be able to share with your instructors the process and the design you have created.

### Optional Requirements
- The first optional should always be looking for improvements within the existing code you have already written. Are there any additional edge cases you might be missing in your tests? Any opportunity to use an enumerable method where you're using an each?
- Enhance the trip functionality to include support for cost and duration
  - Update your CSV file accordingly
- For a given rider, add the ability to return the total amount of money they have spent on all trips
- For a given rider, add the ability to return the total amount of time they have spent on their trips
- For a given driver, calculate their total revenue for all trips. Each driver gets 80% of the trip cost _after_ a fee of $1.65 is subtracted.
