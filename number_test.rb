#!/usr/bin/env ruby

require 'test/unit'

class NumberTest < Test::Unit::TestCase
  
  def test_fixnum
    f = 123_456
    assert_equal(Fixnum, f.class)
  end

  def test_bignum
    b = 123_456_789_123
    assert_equal(Bignum, b.class)
  end

  def test_float
    f = 1.08
    assert_equal(Float, f.class)
  end
  
  def test_hex
    h = 0xaabb
    assert_equal(43707, h)
  end

  def test_octal
    o = 0377 
    assert_equal(255, o)
  end

  def test_binary
    b = 0b1111
    assert_equal(15, b)
  end

  def test_abs
    assert_equal(1, -1.abs)
  end
  
  def test_character_value
    assert_equal(97, ?a)
    assert_equal(10, ?\n)
    assert_equal(1, ?\C-a)
    assert_equal(225, ?\M-a)
  end
   
  def test_times
    a = Array.new
    3.times { |i| a.push(i) }
    assert_equal([0, 1, 2], a)
  end
  
  def test_upto
    a = Array.new
    1.upto(3) { |i| a.push(i) }
    assert_equal([1, 2, 3], a)
  end
  
  def test_downto
    a = Array.new
    3.downto(1) { |i| a.push(i) }
    assert_equal([3, 2, 1], a)
  end
  
  def test_step
    a = Array.new
    10.step(30, 5) { |i| a.push(i) }
    assert_equal([10, 15, 20, 25, 30], a)
  end
  
end
