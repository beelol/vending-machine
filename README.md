# Vending Machine
This is a simple system created with TDD to simulate a Vending Machine that accepts coins, makes change, returns coins, and makes purchases when appropriate.

## Dependencies
To run Vending Machine, your system should have Ruby 2.1.2+ installed, as well as RSpec 3.0+

If you don't have RSpec, simply run the following command:

    gem install rspec

## Running
Once you have downloaded or cloned the repository, assuming it is unzipped, enter the repository in your terminal.

After navigating to its repository, Vending Machine can be run with the following command:

    ruby vending_machine_driver.rb

You can of course also make your own driver, and run it with the ruby command.

## Testing
Vending Machine can be tested with the following command:

    rspec

This is the default command line argument to run the RSpec Gem on a ruby application.

The .rspec file contains details so only files within the ./test/ directory and ending with "\_test.rb" will be run during testing.

## Commands
While running Vending Machine, the program will enter an input loop.

During this loop, the following commands can be input:

    quarter
The "quarter" command will insert a quarter by size and weight.

    dime
The "dime" command will insert a quarter by size and weight.

    nickel
The "nickel" command will insert a quarter by size and weight.

    0
The "0" command will attempt to purchase Cola for $1.00.

    1
The "1" command will attempt to purchase Chips for $0.50

    2
The "2" command will attempt to purchase Chips for $0.65

    return
The "return" command will cause the machine to return all coins inserted by the user.

    exit
The "exit" command will exit the program.
