require 'rspec'
require "./vending_machine.rb"
require "./coin_constants.rb"
require "./product.rb"

vending_machine = VendingMachine.new

RSpec.describe VendingMachine, "#accept" do
    context "with coin details" do
        it "finds nickels respectively" do

            result = vending_machine.get_value_by_coin_details(
                CoinConstants::NICKEL_WEIGHT,
                CoinConstants::NICKEL_THICKNESS,
                CoinConstants::NICKEL_DIAMETER)

            expect(result).to eq CoinConstants::NICKEL_VALUE
        end

        it "finds dimes respectively" do

            result = vending_machine.get_value_by_coin_details(
                CoinConstants::DIME_WEIGHT,
                CoinConstants::DIME_THICKNESS, CoinConstants::DIME_DIAMETER)

            expect(result).to eq CoinConstants::DIME_VALUE
        end

        it "finds quarters respectively" do

            result = vending_machine.get_value_by_coin_details(
                CoinConstants::QUARTER_WEIGHT,
                CoinConstants::QUARTER_THICKNESS, CoinConstants::QUARTER_DIAMETER)

            expect(result).to eq CoinConstants::QUARTER_VALUE
        end

        it "asks the user to insert coins" do

            vending_machine = VendingMachine.new(Product.new("Candy", 65))

            vending_machine.store_coin(
                CoinConstants::QUARTER_WEIGHT,
                CoinConstants::QUARTER_THICKNESS, CoinConstants::QUARTER_DIAMETER, 2)

            vending_machine.store_coin(
                CoinConstants::DIME_WEIGHT,
                CoinConstants::DIME_THICKNESS, CoinConstants::DIME_DIAMETER, 1)

            vending_machine.store_coin(
                CoinConstants::NICKEL_WEIGHT,
                CoinConstants::NICKEL_THICKNESS, CoinConstants::NICKEL_DIAMETER, 1)

            puts vending_machine.get_stored_coin_total_value

            expect { vending_machine.prompt_for_money }.to output(/INSERT COIN/).to_stdout
        end
    end
end
