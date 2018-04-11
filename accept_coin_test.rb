require 'rspec'
require 'coin_constants.rb'

vendingMachine = VendingMachine.new

RSpec.describe VendingMachine, "#accept" do
    context "with coin details" do
        it "finds nickels respectively" do

            result = VendingMachine.GetValueByCoinDetails
            (CoinConstants.NICKEL_WEIGHT, NICKEL_THICKNESS, NICKEL_DIAMETER)

            expect(result).to eq CoinConstants.NICKEL_VALUE
        end

        it "finds dimes respectively" do

            result = VendingMachine.GetValueByCoinDetails
            (CoinConstants.NICKEL_WEIGHT, NICKEL_THICKNESS, NICKEL_DIAMETER)

            expect(result).to eq CoinConstants.NICKEL_VALUE
        end

        it "finds quarters respectively" do

            result = VendingMachine.GetValueByCoinDetails
            (CoinConstants.NICKEL_WEIGHT, NICKEL_THICKNESS, NICKEL_DIAMETER)

            expect(result).to eq CoinConstants.NICKEL_VALUE
        end
    end
end
