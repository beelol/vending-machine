# Vending Machine
This is a simple system created with TDD to simulate a Vending Machine that accepts coins, makes change, returns coins, and makes purchases when appropriate.

## Dependencies
To run Vending Machine, your system should have Ruby 2.1.2+ installed, as well as RSpec 3.0+

If you don't have RSpec, simply run gem install RSpec.

## Running
Vending Machine can be run with the following commands:

    ruby vending_machine_driver.rb

You can of course also make your own driver, and run it with the ruby command.

## Commands
While running Vending Machine, the program will enter an input loop.

During this loop, the following commands can be input:

    quarter
The "quarter" command will insert a quarter by size and weight.

    dime
The "dime" command will insert a quarter by size and weight.

    nickel
The "nickel" command will insert a quarter by size and weight.

    return
The "return" command will cause the machine to return all coins inserted by the user.

    exit
The "exit" command will exit the program.
