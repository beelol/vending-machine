require 'rspec'
require "./coin_details.rb"
require "./vending_machine.rb"
require "./product.rb"

# The purpose of this test is to ensure that the vending machine can select items out of a given list
RSpec.describe VendingMachine, "#selectproduct" do
    context "with an array of products" do
        it "can select a product" do
            product = Product.new("Cola", 100)

            vending_machine = VendingMachine.new(product)

            expect(vending_machine.get_product_at(0)).to eq product
        end

        it "finds each respective product" do
            cola = Product.new("Cola", 100)
            chips = Product.new("Chips", 50)
            candy = Product.new("Candy", 65)

            vending_machine = VendingMachine.new(cola, chips, candy)

            expect(vending_machine.get_product_at(0)).to eq cola
            expect(vending_machine.get_product_at(1)).to eq chips
            expect(vending_machine.get_product_at(2)).to eq candy
        end

        it "purchases a product when selected" do
            cola = Product.new("Cola", 100)
            chips = Product.new("Chips", 50)
            candy = Product.new("Candy", 65)

            vending_machine = VendingMachine.new(cola, chips, candy)

            4.times do
                vending_machine.add_coin(CoinConstants::QUARTER_WEIGHT, CoinConstants::QUARTER_THICKNESS, CoinConstants::QUARTER_DIAMETER)
            end

            vending_machine.select_product(2)

            expect(vending_machine.current_amount).to eq 0
        end
    end
end
