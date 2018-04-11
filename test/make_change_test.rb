require 'rspec'
require "./vending_machine.rb"
require "./coin_constants.rb"

RSpec.describe VendingMachine, "#makechange" do
    vending_machine = VendingMachine.new

    # assume coins is sorted
    coins = [
        CoinConstants.QUARTER_VALUE
        CoinConstants.DIME_VALUE,
        CoinConstants.NICKEL_VALUE,
    ]

    context "with a current amount over 0" do
        it "makes change with minimal amount of coins for use case 1.75" do
            num_quarters = 1.75 / CoinConstants.QUARTER_VALUE

            # store 1.75 without accessor
            num_quarters.times do
                vending_machine.add_coin(CoinConstants.QUARTER_VALUE)
            end

            change = vending_machine.make_change(coins)

            quarters = change.select do |value|
                value == CoinConstants.QUARTER_VALUE
            end

            dimes = change.select do |value|
                value == CoinConstants.DIME_VALUE
            end

            nickels = change.select do |value|
                value == CoinConstants.NICKEL_VALUE
            end

            expect(quarters.length).to eq 7
            expect(dimes.length).to eq 0
            expect(nickels.length).to eq 0
        end

        it "makes change with minimal amount of coins for use case 0.65" do
            # store .65 without accessor
            2.times do
                vending_machine.add_coin(CoinConstants.QUARTER_VALUE)
            end

            vending_machine.add_coin(CoinConstants.DIME_VALUE)
            vending_machine.add_coin(CoinConstants.NICKEL_VALUE)

            change = vending_machine.make_change(coins)

            # grab selected results for each coin value
            quarters = change.select do |value|
                value == CoinConstants.QUARTER_VALUE
            end

            dimes = change.select do |value|
                value == CoinConstants.DIME_VALUE
            end

            nickels = change.select do |value|
                value == CoinConstants.NICKEL_VALUE
            end

            expect(quarters.length).to eq 2
            expect(dimes.length).to eq 1
            expect(nickels.length).to eq 1
        end

        it "makes change with minimal amount of coins for use case 0.40" do
            # add 0.40 without accessor
            vending_machine.add_coin(CoinConstants.QUARTER_VALUE)
            vending_machine.add_coin(CoinConstants.DIME_VALUE)
            vending_machine.add_coin(CoinConstants.NICKEL_VALUE)

            change = vending_machine.make_change(coins)

            quarters = change.select do |value|
                value == CoinConstants.QUARTER_VALUE
            end

            dimes = change.select do |value|
                value == CoinConstants.DIME_VALUE
            end

            nickels = change.select do |value|
                value == CoinConstants.NICKEL_VALUE
            end

            expect(quarters.length).to eq 1
            expect(dimes.length).to eq 1
            expect(nickels.length).to eq 1
        end
    end
end
