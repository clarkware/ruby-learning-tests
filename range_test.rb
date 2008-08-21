#!/usr/bin/env ruby

require 'test/unit'

class RangeTest < Test::Unit::TestCase
  
  def test_inclusive
    range = 0..10
    assert_equal(true, range.include?(0))
    assert_equal(true, range.include?(10))
    assert_equal(false, range.include?(11))
  end  	

  def test_exclusive
    range = 0...10
    assert_equal(true, range.include?(0))
    assert_equal(false, range.include?(10))
  end  	
  
  def test_min_and_max
    range = 0..10
    assert_equal(0, range.min)
    assert_equal(10, range.max)
  end 
  
  def test_to_array
    assert_equal([0, 1, 2], (0..2).to_a)
    assert_equal([0, 1],    (0...2).to_a)
  end
  
  def test_reject
    range = 0..10
    accepted = range.reject { |i| i > 2 }
    assert_equal([0, 1, 2], accepted)
  end 
  
  def test_each
    range = 0..3
    result = []
    range.each { |i| result << i }
    assert_equal([0, 1, 2, 3], result)
  end 
  
  def test_interval
    range = 0..3
    assert_equal(true, range.member?(3))
    assert_equal(true, range === 3)

    range = 0...3
    assert_equal(false, range === 3)
    assert_equal(false, range.member?(3))
  end 

  def test_range_of_objects
    medium = Volume.new(4)..Volume.new(7)
    assert_equal(false, medium.include?(Volume.new(3)))
    assert_equal(true, medium.include?(Volume.new(5)))
  end
  
end

class Volume

  include Comparable

  attr :volume

  def initialize(volume) # 0..9
    @volume = volume
  end

  # Support for ranges

  def <=>(other)
    self.volume <=> other.volume
  end

  def succ
    raise(IndexError, "Volume too big") if @volume >= 9
    Volume.new(@volume.succ)
  end
end
