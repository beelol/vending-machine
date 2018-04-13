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

    def can_make_change_for_every_product
        @products.each do |product, count|
            unless can_make_change_for_amount(product.price)
                return false
            end
        end

        true
    end

    def can_make_change_for_amount(amount)
        (make_change_for_amount(amount, true).inject(0) {|sum, coin| sum + coin }) == amount
    end

    # we use this function to check if we can and make change
    # so we use check to ensure coins are not removed if it's possible
    # to make appropriate change
    def make_change_for_amount(amount, check = false)
        remaining_returns = amount

        change = []

        @coins.each do |coin, count|
            num_coins = count

            while num_coins > 0 && ((remaining_returns - @@coin_value_by_details[coin]) >= 0)
                # remove amount we need less
                remaining_returns -= @@coin_value_by_details[coin]
                change << @@coin_value_by_details[coin]

                num_coins -= 1
            end

            @coins[coin] = num_coins unless check

            break if remaining_returns == 0
        end

        change
    end

    def prompt_for_money
        # if we can make change for both the current amount and each product, we ask for a coin can_make_change &&
        if can_make_change_for_every_product
            puts "INSERT COIN"

        # otherwise inform the user that they need to insert exact change
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
        if @user_coins.empty?
            puts "NO COINS TO RETURN IN MACHINE"
            return
        end

        puts "COINS RETURNED IN SLOT BELOW: #{@user_coins.map {|coin| coin.to_f / 100}}"
        @user_coins.clear
        @current_amount = 0
    end

    def purchase(product)

        if can_purchase_product? product
            @current_amount -= product.price

            unless can_make_change_for_amount(@current_amount)
                puts "CANNOT MAKE CHANGE"
                return_coins

                return
            end

            @products[product] -= 1

            puts "THANK YOU"
        else
            if @products.has_key?(product) && @products[product] < 1
                puts "SOLD OUT"
                return false
            end

            puts "PRICE: #{product.price.to_f / 100}"
            return false
        end

        true
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
        if purchase get_product_at(index)

            # coins are stored as integers, so we need to convert them down to cents
            change_to_return = make_change.map { |num| num.to_f / 100 }

            unless change_to_return.empty?
                puts "CHANGE IN SLOT BELOW: #{change_to_return.to_s}"
            end

            @user_coins.clear
            @current_amount = 0
        end
    end

    def make_change
        make_change_for_amount @current_amount
    end
end
