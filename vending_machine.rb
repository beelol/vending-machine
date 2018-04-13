require "./coin_constants.rb"
require "./coin_details.rb"
require "./product.rb"

class VendingMachine
    attr_reader :current_amount

    def initialize(*products)
        @current_amount = 0.00
        @products = {}
        @coins = {}
        @user_coins = []

        products.each { |product| @products[product] = 1 }
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
    def get_stored_coin_total_value
        # @coins.values.inject(0) {|sum, coin| sum + coin }
        @coins.keys.inject(0) {|sum, coin| sum + @@coin_value_by_details[coin] * @coins[coin] }
    end

    def min_product_value
        min = @products.keys[0].price

        @products.keys.each do |product|
            if product.price < min
                min = product.price
            end
        end

        min
    end

    def can_make_change
        return false unless get_stored_coin_total_value >= min_product_value

        # we need to ensure that the sum of making change will actually return the current_amount, which is the change we want

        # current amount is the change we want because the price is removed from it before making change

        (make_change.inject(0) {|sum, coin| sum + coin }) == @current_amount
        # if we have enough to exchange for the minimum product,
        # we don't need exact change and can return the amount
    end

    def prompt_for_money
        if can_make_change
            puts "INSERT COIN"
        else
            puts "EXACT CHANGE ONLY"
        end
    end

    def store_coin(weight, thickness, diameter, count)
        coin = CoinDetails.new(weight, thickness, diameter)
        if @coins.has_key? coin
            @coins[coin] += count
        else
            @coins[coin] = count
        end
    end

    def get_coin_count(weight, thickness, diameter)
        coin = CoinDetails.new(weight, thickness, diameter)

        if @coins.has_key? coin
            return @coins[CoinDetails.new(weight, thickness, diameter)]
        end

        0
    end

    def get_value_by_coin_details(weight, thickness, diameter)
        coin = CoinDetails.new(weight, thickness, diameter)

        unless @@coin_value_by_details.has_key? coin
            return nil
        end

        @@coin_value_by_details[coin]
    end

    def add_coin(weight, thickness, diameter)
        value = get_value_by_coin_details(weight, thickness, diameter)

        if value.nil?
            puts "INVALID COIN. QUARTERS, DIMES, AND NICKELS ONLY, PLEASE."

            return
        end

        @user_coins << value

        @current_amount += value

        puts "CURRENT AMOUNT: #{@current_amount.to_f / 100}"
    end

    def return_coins
        puts "COINS RETURNED IN SLOT BELOW"
        @user_coins.clear
        @current_amount = 0
    end

    def purchase(product)
        if can_purchase_product? product
            @current_amount -= product.price

            @products[product] -= 1

            puts "THANK YOU"
        else
            if @products.has_key?(product) && @products[product] < 1
                puts "SOLD OUT"
                return
            end

            puts "PRICE: #{product.price.to_f / 100}"
        end
    end

    def can_purchase_product?(product)
        product.can_be_purchased_with?(@current_amount) && @products.has_key?(product) && @products[product] > 0
    end

    def add_product(product, count)
        if @products.has_key? product
            @products[product] += count
        else
            @products[product] = count
        end
    end

    def get_product_at(index)
        @products.keys[index]
    end

    def get_product_count_at(index)
        key = @products.keys[index]
        @products[key]
    end

    def select_product(index)
        purchase get_product_at(index)

        # return what's left to the user
        make_change

        # clear the amount
        @current_amount = 0
    end

    def make_change
        remaining_returns = @current_amount

        change = []

        @coins.each do |coin, count|
            # break if remaining_returns == 0
            #
            # puts remaining_returns
            # puts @@coin_value_by_details[coin]

            while @coins[coin] > 0 && remaining_returns - @@coin_value_by_details[coin] >= 0
                num_coins = (@coins[coin] -= 1)

                remaining_returns -= @@coin_value_by_details[coin]
                change << @@coin_value_by_details[coin]
            end

            break if remaining_returns == 0
        end

        # puts change
        change
    end
end
