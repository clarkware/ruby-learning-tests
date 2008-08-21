#!/usr/bin/env ruby

require 'test/unit'

class ControlStructuresTest < Test::Unit::TestCase
  
  def test_while
    x = 0
    while x < 10
      x += 1
    end
    assert_equal(10, x)
  end
  
  def test_while_modifier
    x = 0
    x += 1 while x < 10
    assert_equal(10, x)
  end

  def test_until
    x = 0
    until x == 10
      x += 1
    end
    assert_equal(10, x)
  end
  
  def test_until_modifier
    x = 0
    x += 1 until x == 10
    assert_equal(10, x)
  end
  
  def test_for
    numbers = [1, 2, 3]
    x = 0
    for i in numbers
      x += i
    end
    assert_equal(6, x)
  end
  
  # test above translates into...

  def test_for_iterator
    numbers = [1, 2, 3]
    x = 0
    numbers.each { |i| x += i }
    assert_equal(6, x)
  end

  def test_for_upto
    x = 0
    1.upto(3) { |i| x += i }
    assert_equal(6, x)
  end

  def test_loop
    x = 0
    loop do
      x += 1
      break if x > 4
    end
    assert_equal(5, x)
  end

  def test_loop_next
    numbers = []
    x = 0
    loop do
      x += 1
      next if x < 3
      numbers << x
      break if x > 4
    end
    assert_equal([3, 4, 5], numbers)
  end

  def test_retry
    numbers = []
    for i in 1..3
      numbers << i
      retry if i == 3 and numbers.length < 6
    end
    assert_equal([1, 2, 3, 1, 2, 3], numbers)
  end

end
