require 'rspec'
require "./coin_constants.rb"

vendingMachine = VendingMachine.new

RSpec.describe VendingMachine, "#accept" do
    context "with coin details" do
        it "finds nickels respectively" do

            result = vendingMachine.GetValueByCoinDetails(CoinConstants.NICKEL_WEIGHT, NICKEL_THICKNESS, NICKEL_DIAMETER)

            expect(result).to eq CoinConstants.NICKEL_VALUE
        end

        it "finds dimes respectively" do

            result = vendingMachine.GetValueByCoinDetails(CoinConstants.DIME_WEIGHT, DIME_THICKNESS, DIME_DIAMETER)

            expect(result).to eq CoinConstants.DIME_VALUE
        end

        it "finds quarters respectively" do

            result = vendingMachine.GetValueByCoinDetails(CoinConstants.QUARTER_WEIGHT, QUARTER_THICKNESS, QUARTER_DIAMETER)

            expect(result).to eq CoinConstants.QUARTER_VALUE
        end
    end
end
