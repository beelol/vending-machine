require "./coin_constants.rb"
require "./coin_details.rb"
require "./product.rb"
require "./vending_machine.rb"

# Here we define hashes storing references to coin details.
# This is for ease of use. This way, we can convert user input to coin details.
# For example, I say "nickel", then the program inserts a nickel's weight, thickness, and diameter into the vending machine.
# The vending machine then determines that we inserted a nickle based on these criteria, and stores the amount.

quarter_details = {
    weight: CoinConstants::QUARTER_WEIGHT,
    thickness: CoinConstants::QUARTER_THICKNESS,
    diameter: CoinConstants::QUARTER_DIAMETER
}

dime_details = {
    weight: CoinConstants::DIME_WEIGHT,
    thickness: CoinConstants::DIME_THICKNESS,
    diameter: CoinConstants::DIME_DIAMETER
}

nickel_details = {
    weight: CoinConstants::NICKEL_WEIGHT,
    thickness: CoinConstants::NICKEL_THICKNESS,
    diameter: CoinConstants::NICKEL_DIAMETER
}

# This hash is used to point user input to the previously define
# detail hashes
coin_options = {
    quarter: quarter_details,
    dime: dime_details,
    nickel: nickel_details
}
# There are three products: cola for $1.00, chips for $0.50, and candy for $0.65. Here we store the three products.

cola = Product.new("Cola", 100)
chips = Product.new("Chips", 50)
candy = Product.new("Candy", 65)

vending_machine = VendingMachine.new

vending_machine.add_product(cola, 10)
vending_machine.add_product(chips, 5)
vending_machine.add_product(candy, 2)

vending_machine.store_coin(quarter_details[:weight], quarter_details[:thickness], quarter_details[:diameter], 8)

vending_machine.store_coin(dime_details[:weight], dime_details[:thickness], dime_details[:diameter], 4)

vending_machine.store_coin(nickel_details[:weight], nickel_details[:thickness], nickel_details[:diameter], 5)

puts "AVAILABLE PRODUCTS: 0:Cola $1.00, 1:Chips $0.50, 2:Candy $0.65"

while true
    vending_machine.prompt_for_money

    input = gets.chomp

    product_selection = /[0-9]/.match(input)

    unless product_selection.nil?
        vending_machine.select_product(product_selection[0].to_i)
    else
        coin_details = coin_options[input.to_sym]

        unless coin_details.nil?
            vending_machine.add_coin(coin_details[:weight], coin_details[:thickness], coin_details[:diameter])
        else
            puts "INVALID COIN. QUARTERS, DIMES, AND NICKLES ONLY PLEASE. EXAMPLE FORMAT: nickel"
        end
    end
end
