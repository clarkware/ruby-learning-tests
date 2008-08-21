#!/usr/bin/env ruby

require 'test/unit'

class ArrayTest < Test::Unit::TestCase

  def test_new_array_literal
    a = [3.14, "pie", 99]
    assert_equal(Array, a.class)
    assert_equal(3, a.length)   
    assert_equal(3.14, a[0]) 
    assert_equal("pie", a[1]) 
    assert_equal(99, a[2]) 
    assert_nil(a[3])
  end

  def test_new_array
    a = Array.new
    assert_equal(Array, a.class)
    a[0] = 3.14
    a[1] = "pie"
    a[2] = 99
    assert_equal(3, a.length)
    assert_equal([3.14, "pie", 99], a)
  end

  def test_new_array_with_block
    a = Array.new(3) { |i| i + 2 }
    assert_equal([2, 3, 4], a)
  end

  def test_array_of_words
    a = %w{ ireland scotland england }
    assert_equal(["ireland", "scotland", "england"], a)
  end
  
  def test_index_negative
    a = [ 1, 3, 5 ]
    assert_equal(5, a[-1])
    assert_equal(3, a[-2])
    assert_equal(1, a[-3])
    assert_nil(a[-99])
  end
  
  def test_index_by_start_and_count
    a = [ 1, 3, 5, 7 ]
    assert_equal([1], a[0, 1])
    assert_equal([1, 3], a[0, 2])
    assert_equal([3, 5, 7], a[1, 3])
    assert_equal([7], a[3, 1])
    assert_equal([3, 5], a[-3, 2])
  end
  
  def test_index_by_range
    a = [ 1, 3, 5, 7 ]
    assert_equal([1, 3, 5], a[0..2])
    assert_equal([1, 3], a[0...2])
    assert_equal([3], a[1..1])
    assert_equal([], a[1...1])
    assert_equal([3, 5, 7], a[-3..-1])
  end
  
  def test_single_index_change
    a = [ 1, 3, 5, 7, 9 ]

    a[1] = "bat"
    assert_equal([1, "bat", 5, 7, 9], a)

    a[-3] = "cat"
    assert_equal([1, "bat", "cat", 7, 9], a)

    a[3] = [9, 8]
    assert_equal([1, "bat", "cat", [9, 8], 9], a)

    a[6] = 99
    assert_equal([1, "bat", "cat", [9, 8], 9, nil, 99], a)
  end
  
  def test_range_change
    a = [ 1, 3, 5, 7, 9 ]

    a[2, 2] = 'cat'
    assert_equal([1, 3, "cat", 9], a)

    a[2, 0] = 'dog'
    assert_equal([1, 3, "dog", "cat", 9], a)

    a[1, 1] = [9, 8, 7]
    assert_equal([1, 9, 8, 7, "dog", "cat", 9], a)

    a[0..3] = []
    assert_equal(["dog", "cat", 9], a)

    a[5..6] = 99, 98
    assert_equal(["dog", "cat", 9, nil, nil, 99, 98], a)
  end
  
  def test_clear
    a = [1, 2, 3]
    assert_equal([], a.clear())
  end
  
  def test_push_pop_shift
    a = Array.new
    a.push("A")
    a.push("B")
    a.push("C")
    assert_equal(["A", "B", "C"], a)
    assert_equal("A", a.shift)
    assert_equal("C", a.pop)
    assert_equal("B", a.pop)
    assert_equal(nil, a.pop)
  end
  
  def test_each
    a = ["A", "B", "C"]
    s = ""
    a.each { |element| s += element } 
    assert_equal("ABC", s)
  end

  def test_sort
    a = [3, 1, 7, 0]
    assert_equal([0, 1, 3, 7], a.sort)
  end
    
  def test_reverse
    a = [3, 1, 7, 0]
    assert_equal([0, 7, 1, 3], a.reverse)
  end

  def test_join
    a = ["a", "b", "c"]
    assert_equal("abc", a.join)
    assert_equal("a-b-c", a.join("-"))
  end
  
  def test_array_of_hashes
    a = Array.new(size=2) { Hash.new(0) }
    assert_equal([{}, {}], a)
  end
  
  def test_array_of_arrays
  	a = Array.new(size=2) { Array.new(count=1, obj="A") }
  	assert_equal([["A"], ["A"]], a)
  end
  
end