#!/usr/bin/env ruby

require 'test/unit'

class PipeTest < Test::Unit::TestCase
    
  def test_power_source
    power_source = ""
    IO.popen("scutil", "r+") do |pipe|
      pipe.puts %{
        open 
        get State:/IOKit/PowerSources/InternalBattery-0
        d.show
        close
      }
      pipe.close_write
      while line = pipe.gets
        if line =~ /Power Source State : (.+)\s*$/
          power_source = $1
        end
      end
    end
    # assert_match(/(AC|Battery) Power/, power_source)
  
  end

end
