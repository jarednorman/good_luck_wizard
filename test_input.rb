#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative "lib/glw"

puts "Input Test - Press keys to see symbols (press 'q' to quit)"
puts "Try: letters, numbers, arrows, ESC, space, tab, enter, backspace"
puts "-" * 60

IO.console.raw do
  GLW::Input.start!

  loop do
    key = GLW::Input.pop
    puts "Received: #{key.inspect}"

    break if key == :k_q
  end
end

puts "\nExiting..."
