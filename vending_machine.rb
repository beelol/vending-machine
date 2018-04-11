require "./coin_constants.rb"
require "./coin_details.rb"

class VendingMachine
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

    def GetValueByCoinDetails(weight, thickness, diameter)
        return @@coin_value_by_details[CoinDetails.new(weight, thickness, diameter)]
    end

end
