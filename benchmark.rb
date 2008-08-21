#!/usr/bin/env ruby

require "benchmark"

Benchmark.bm(label_width = 10) do |test|

  loops = 50000

  test.report("for:") do
    y = 0
    (1..loops).each { |x| y += x }
  end

  test.report("times:") do
    y = 0
    loops.times { |x| y += x }
  end

  test.report("upto:") do 
    y = 0
    1.upto(loops) { |x| y += x }
  end

end
