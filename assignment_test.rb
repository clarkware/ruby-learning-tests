#!/usr/bin/env ruby

require 'test/unit'

class AssignmentTest < Test::Unit::TestCase
  
  def test_chained
    a = b = 1 + 2
    assert_equal(3, a)
    assert_equal(3, b)
    assert_equal(3, a = b = 3)
  end

  def test_parallel
    a = 1
    b = 2
    a, b = b, a
    assert_equal(2, a)
    assert_equal(1, b)
  end

  def test_more_lvalues_than_rvalues
    a, b = 1
    assert_equal(1, a)
    assert_equal(nil, b)
  end

  def test_more_rvalues_than_lvalues
    a, b = 1, 2, 3
    assert_equal(1, a)
    assert_equal(2, b)
  end

  def test_one_lvalue_many_rvalues
    a = 1, 2, 3
    assert_equal([1, 2, 3], a)
  end

  def test_array
    a = [1, 2, 3]
    b, c = a
    assert_equal(1, b)
    assert_equal(2, c)

    b, c = 99, a
    assert_equal(99, b)
    assert_equal([1, 2, 3], c)
  end

  def test_collapse_array
    a = [1, 2, 3]
    b, *c = a
    assert_equal(1, b)
    assert_equal([2, 3], c)
  end

  def test_expand_array
    a = [1, 2, 3]
    b, c = 99, *a
    assert_equal(99, b)
    assert_equal(1, c)
  end

  def test_nested
    a, (b, c), d = 1, 2, 3, 4
    assert_equal(1, a)
    assert_equal(2, b)
    assert_equal(nil, c)
    assert_equal(3, d)
  end

  def test_nested_array
    a, (b, c), d = 1, [2, 3, 4], 5
    assert_equal(1, a)
    assert_equal(2, b)
    assert_equal(3, c)
    assert_equal(5, d)
  end

end
