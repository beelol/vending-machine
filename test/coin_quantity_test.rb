require 'rspec'
require "./vending_machine.rb"
require "./product.rb"
require "./coin_constants.rb"

RSpec.describe VendingMachine, "#coinquantity" do
    context "with a quantity of coins" do
        it "stores the appropriate amount" do
            vending_machine = VendingMachine.new
            cola = Product.new("Cola", 1)

            vending_machine.store_coin(CoinConstants::QUARTER_WEIGHT, CoinConstants::QUARTER_THICKNESS, CoinConstants::QUARTER_DIAMETER, 4)

            vending_machine.purchase(cola)

            expect(vending_machine.get_coin_count(CoinConstants::QUARTER_WEIGHT, CoinConstants::QUARTER_THICKNESS, CoinConstants::QUARTER_DIAMETER)).to eq 4
        end

        it "prompts the user for exact change when necessary" do
            vending_machine = VendingMachine.new
            cola = Product.new("Cola", 1)

            expect(vending_machine.prompt_for_money().to output("EXACT CHANGE ONLY").to_stdout
        end
    end
end
