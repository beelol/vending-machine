require 'rspec'
require "./vending_machine.rb"
require "./coin_constants.rb"

RSpec.describe VendingMachine, "#returncoins" do
    vending_machine = VendingMachine.new

    context "with inserted coins" do
        it "returns the same coins" do
            vending_machine.add_coin(CoinConstants::QUARTER_WEIGHT, CoinConstants::QUARTER_THICKNESS, CoinConstants::QUARTER_DIAMETER)

            vending_machine.return_coins

            expect(vending_machine.current_amount).to eq 0
        end
    end
end
