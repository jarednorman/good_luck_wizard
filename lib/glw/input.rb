# frozen_string_literal: true

module GLW
  class Input
    ESCAPE_TIMEOUT = 0.02 # 20ms

    BYTES = {
      "\t" => :k_tab,
      "\r" => :k_enter,
      "\n" => :k_enter,
      "\x7F" => :k_backspace,
      "\b" => :k_backspace,
      " " => :k_space,
      "\x03" => :k_ctrl_c,
      "[" => :k_left_bracket,
      "]" => :k_right_bracket,
      ";" => :k_semicolon,
      "'" => :k_single_quote,
      "," => :k_comma,
      "." => :k_period
    }.tap do |h|
      ("a".."z").each { |c| h[c] = :"k_#{c}" }
      ("A".."Z").each { |c| h[c] = :"k_#{c}" }
      ("0".."9").each { |c| h[c] = :"k_#{c}" }
    end

    def initialize
      @queue = nil
    end

    def pop
      @queue.pop
    end

    def empty?
      @queue.empty?
    end

    def start!
      return if @queue

      @queue = Thread::Queue.new

      Thread.new do
        loop do
          byte = read_byte

          if byte == "\e"
            handle_escape byte
          else
            handle_byte byte
          end
        rescue EOFError
          break
        end
      end
    end

    private

    def handle_escape(first_byte)
      second_byte = read_byte(timeout: true)

      if second_byte.nil?
        @queue << :k_escape
        nil
      elsif second_byte == "["
        third_byte = read_byte(timeout: true)

        case third_byte
        when "A"
          @queue << :k_up
        when "B"
          @queue << :k_down
        when "C"
          @queue << :k_right
        when "D"
          @queue << :k_left
        else
          @queue << :k_escape
          handle_byte second_byte
          handle_byte third_byte if third_byte
        end
      else
        @queue << :k_escape
        handle_byte second_byte
      end
    end

    def handle_byte(byte)
      return unless BYTES.key?(byte)

      @queue << BYTES[byte]
    end

    def read_byte(timeout: false)
      return if timeout && !IO.select([STDIN], nil, nil, 0.02)

      STDIN.readpartial(1)
    end
  end
end
