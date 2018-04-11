
# The CoinDetails class is used to wrap coin information
# and identify coin values as a hash key
class CoinDetails
    attr_reader :weight, :thickness, :diameter

    def initialize(weight, thickness, diameter)
        @weight = weight
        @thickness = thickness
        @diameter = diameter
    end

    def eql?(other)
        @weight == other.weight && @thickness == other.thickness && @diameter == other.diameter
    end

    def hash
     [ @weight, @thickness, @diameter ].hash
    end
end
