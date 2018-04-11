require 'rspec'
require "./coin_details.rb"

# The purpose of this test is to ensure there are no issues
# when making new coin detail objects to receive information from
# the coin detail hash
RSpec.describe CoinDetails, "#accept" do
    context "with coin details" do
        it "finds the respective value" do
            details = CoinDetails.new(1, 5, 7)

            coin_detail_hash = { details => 0.5}

            expect(coin_detail_hash[details]).to eq 0.5
        end

        it "finds the respective value with multiple pairs" do
            details = CoinDetails.new(1, 5, 7)
            other_details = CoinDetails.new(4, 7, 8)

            coin_detail_hash = { details => 0.5, other_details => 0.1 }

            expect(coin_detail_hash[other_details]).to eq 0.1
        end
    end
    context "with two identical coin detail objects as keys" do
        it "finds the same value" do
            coin_detail_hash = { CoinDetails.new(1, 2, 3) => 0.5}

            expect(coin_detail_hash[CoinDetails.new(1, 2, 3)]).to eq coin_detail_hash[CoinDetails.new(1, 2, 3)]
        end
    end
end
