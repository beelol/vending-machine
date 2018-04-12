#test for

# As a vendor
# I want customers to select products
# So that I can give them an incentive to put money in the machine
#
# There are three products: cola for $1.00, chips for $0.50, and candy for $0.65. When the respective button is pressed and enough money has been inserted, the product is dispensed and the machine displays THANK YOU. If the display is checked again, it will display INSERT COIN and the current amount will be set to $0.00. If there is not enough money inserted then the machine displays PRICE and the price of the item and subsequent checks of the display will display either INSERT COIN or the current amount as appropriate.

# so perhaps we should have a product class: name and value
# can_be_purchased_with?(amount)

# array of products 0, 1, 2 as we grab them by index from the vendor anyway

# vending machine needs a private current_amount,

require 'rspec'
require "./coin_details.rb"
require "./vending_machine.rb"
require "./product.rb"

# The purpose of this test is to ensure that the vending machine can be used to purchase 3 different items properly
RSpec.describe Product, "#purchaseproduct" do
    context "with a product" do
        it "can be purchased with appropriate amount" do
            vending_machine = VendingMachine.new
            product = Product.new("Cola", 1)

            4.times do
                vending_machine.add_coin(CoinConstants::QUARTER_WEIGHT, CoinConstants::QUARTER_THICKNESS, CoinConstants::QUARTER_DIAMETER)
            end

            expect(product.can_be_purchased_with?(vending_machine.current_amount)).to be true
        end

        it "uses the current amount to purchase items" do
            product = Product.new("Cola", 1)
            vending_machine = VendingMachine.new(product)

            4.times do
                vending_machine.add_coin(CoinConstants::QUARTER_WEIGHT, CoinConstants::QUARTER_THICKNESS, CoinConstants::QUARTER_DIAMETER)
            end

            vending_machine.purchase(product)

            expect(vending_machine.current_amount).to eq 0
        end

        it "cannot purchase an item that is more expensive than current amount" do
            vending_machine = VendingMachine.new
            product = Product.new("Cola", 1)

            3.times do
                vending_machine.add_coin(CoinConstants::QUARTER_WEIGHT, CoinConstants::QUARTER_THICKNESS, CoinConstants::QUARTER_DIAMETER)
            end

            expect(product.can_be_purchased_with?(vending_machine.current_amount)).to be false
        end
    end
end
