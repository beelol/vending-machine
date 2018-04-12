require 'rspec'
require "./vending_machine.rb"
require "./product.rb"
require "./coin_constants.rb"

RSpec.describe VendingMachine, "#soldout" do
    context "with a quantity of products" do
        it "removes 1 instance of a purchased item" do
            vending_machine = VendingMachine.new
            cola = Product.new("Cola", 1)

            vending_machine.add_product(cola, 5)

            4.times do
                vending_machine.add_coin(CoinConstants::QUARTER_WEIGHT,
                CoinConstants::QUARTER_THICKNESS, CoinConstants::QUARTER_DIAMETER)
            end

            vending_machine.purchase(cola)

            expect(vending_machine.get_product_count_at(0)).to eq 4
        end

        it "does not remove items that are sold out" do
            vending_machine = VendingMachine.new
            cola = Product.new("Cola", 1)

            vending_machine.add_product(cola, 0)

            4.times do
                vending_machine.add_coin(CoinConstants::QUARTER_WEIGHT,
                CoinConstants::QUARTER_THICKNESS, CoinConstants::QUARTER_DIAMETER)
            end

            vending_machine.purchase(cola)

            expect(vending_machine.current_amount).to eq 1
        end
    end
end
