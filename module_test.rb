#!/usr/bin/env ruby

require 'test/unit'

class ModuleTest < Test::Unit::TestCase

  def test_module
    assert_equal(3.14159, Trig::PI)
    assert_equal(0.0, Trig.sin(0))
  end
  
  def test_nested_module
    assert_equal("A::B", A::B.new.class.name)
    assert_equal("Yum", A::B::PI)
    assert_equal("So bad!", A::B.sin)
  end
  
end

module Trig
  
  PI = 3.14159
  
  def Trig.sin(x)
    Math.sin(x) 
  end

end

module A
  class B
    PI = "Yum"
    
    def B.sin
      "So bad!"
    end
  end
end
