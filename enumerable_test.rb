#!/usr/bin/env ruby

require 'test/unit'

class EnumerableTest < Test::Unit::TestCase

  def test_find
    a = ["A", "B", "C"]
    result = a.find { |element| element == "B" }
    assert_equal("B", result)
  end
  
  def test_each_with_index
    a = ["A", "B", "C"]
    s = ""
    a.each_with_index { |element, index| s += element + index.to_s} 
    assert_equal("A0B1C2", s)
  end
  
  def test_collect
    a = ["H", "A", "L"]
    collected = a.collect { |element| element.succ }
    assert_equal(["I", "B", "M"], collected)
  end

  def test_sort
    a = [3, 1, 7, 0]
    assert_equal([0, 1, 3, 7], a.sort)
  end

  def test_inject
    a = [ 1, 3, 5, 7 ]
    result = a.inject(0) { |sum, element| sum + element }
    assert_equal(16, result)

    result = a.inject { |sum, element| sum + element }
    assert_equal(16, result)
  end
  	
end