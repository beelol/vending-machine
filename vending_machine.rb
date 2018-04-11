require "./coin_constants.rb"
require "./coin_details.rb"
require "./product.rb"

class VendingMachine
    attr_reader :current_amount

    def initialize(*products)
        @current_amount = 0.00
        @products = products
    end

    # Reference coin values by their physical details
    @@coin_value_by_details = {
        CoinDetails.new(CoinConstants::NICKEL_WEIGHT,
            CoinConstants::NICKEL_THICKNESS, CoinConstants::NICKEL_DIAMETER) => CoinConstants::NICKEL_VALUE,

        CoinDetails.new(CoinConstants::DIME_WEIGHT,
            CoinConstants::DIME_THICKNESS, CoinConstants::DIME_DIAMETER) =>
            CoinConstants::DIME_VALUE,

        CoinDetails.new(CoinConstants::QUARTER_WEIGHT,
            CoinConstants::QUARTER_THICKNESS, CoinConstants::QUARTER_DIAMETER) => CoinConstants::QUARTER_VALUE,
    }

    def get_value_by_coin_details(weight, thickness, diameter)
        @@coin_value_by_details[CoinDetails.new(weight, thickness, diameter)]
    end

    def add_coin(weight, thickness, diameter)
        value = get_value_by_coin_details(weight, thickness, diameter)

        @current_amount += value
    end

    def purchase(product)
        if product.can_be_purchased_with? current_amount
            @current_amount -= product.price
        end
    end

    def get_product_at(index)
        @products[index]
    end

    def select_product(index)
        purchase get_product_at(index)
    end

    def make_change(coins)
        remaining_returns = @current_amount

        change = []

        coins.each do |coin|
            break if remaining_returns == 0
            while remaining_returns - coin >= 0
                remaining_returns -= coin
                change << coin
            end
        end

        change
    end
end
