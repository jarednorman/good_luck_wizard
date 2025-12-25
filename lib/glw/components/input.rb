module GLW
  module Components
    Input = Data.define(:events) do
      def self.make
        new(events: [])
      end

      def push(event)
        events << event
      end

      def pop
        events.pop
      end

      def peek
        events.last
      end
    end
  end
end
