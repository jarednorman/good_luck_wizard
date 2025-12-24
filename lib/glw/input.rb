module GLW
  module Input
    class << self
      def start!
        return if @queue

        @queue = Thread::Queue.new

        Thread.new do
          loop do
            content = STDIN.readpartial(1)
            @queue.push(content)
          end
        end
      end

      def pop
        @queue.pop
      end
    end
  end
end
