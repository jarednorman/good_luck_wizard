module GLW
  class Terminal
    def self.with(&block)
      new(IO.console).with(&block)
    end

    def initialize(io)
      @io = io
    end

    def with
      @io.raw { yield self }
    end
  end
end
