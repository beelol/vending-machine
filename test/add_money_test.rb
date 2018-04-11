require 'rspec'
require "./coin_details.rb"
require "./vending_machine.rb"

vending_machine = VendingMachine.new
# The purpose of this test is to ensure that the vending machine can be used to purchase 3 different items properly
RSpec.describe VendingMachine, "#addmoney" do
    context "with coin details" do
        it "adds money" do
            previous_vending_machine_amount = vending_machine.current_amount

            vending_machine.add_coin(CoinConstants::QUARTER_WEIGHT,
                CoinConstants::QUARTER_THICKNESS, CoinConstants::QUARTER_DIAMETER)

            expect(vending_machine.current_amount).to be > previous_vending_machine_amount
        end

        it "adds the respective value of a nickel based on details" do
            vending_machine = VendingMachine.new

            vending_machine.add_coin(CoinConstants::NICKEL_WEIGHT,
                CoinConstants::NICKEL_THICKNESS, CoinConstants::NICKEL_DIAMETER)

            expect(vending_machine.current_amount).to eq CoinConstants::NICKEL_VALUE
        end

        it "adds the respective value of a dime based on details" do
            vending_machine = VendingMachine.new

            vending_machine.add_coin(CoinConstants::DIME_WEIGHT,
                CoinConstants::DIME_THICKNESS, CoinConstants::DIME_DIAMETER)

            expect(vending_machine.current_amount).to eq CoinConstants::DIME_VALUE
        end

        it "adds the respective value of a quarter based on details" do
            vending_machine = VendingMachine.new

            vending_machine.add_coin(CoinConstants::QUARTER_WEIGHT,
                CoinConstants::QUARTER_THICKNESS, CoinConstants::QUARTER_DIAMETER)

            expect(vending_machine.current_amount).to eq CoinConstants::QUARTER_VALUE
        end
    end
end
