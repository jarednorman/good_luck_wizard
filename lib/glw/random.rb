module GLW
  class Random
    MASK64 = (1 << 64) - 1
    MASK32 = (1 << 32) - 1
    CONST = 0x2545F4914F6CDD1D

    def initialize(seed)
      @state = seed & MASK64
    end

    def integer
      x = state
      x = (x ^ (x >> 12)) & MASK64
      x = (x ^ (x << 25)) & MASK64
      x = (x ^ (x >> 27)) & MASK64
      self.state = x

      (((x * CONST) & MASK64) >> 32) & MASK32
    end

    def float
      integer.to_f / (1 << 32)
    end

    private

    attr_accessor :state
  end
end
