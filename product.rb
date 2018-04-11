class Product
    attr_reader :name, :price

    def initialize(name, price)
        @name = name;
        @price = price;
    end

    def can_be_purchased_with?(amount)
        amount >= price
    end
end
