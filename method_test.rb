#!/usr/bin/env ruby

require 'test/unit'

class MethodTest < Test::Unit::TestCase
  
  def test_add
    assert_equal(6, add(1, 2, 3))
  end

  def add(x, y, z)
    x + y + z
  end

  def test_default_argument_values
    assert_equal("A B C", default_values())
    assert_equal("1 B C", default_values("1"))
    assert_equal("1 2 C", default_values("1", "2"))
    assert_equal("1 2 3", default_values("1", "2", "3"))
  end
  
  def default_values(arg1="A", arg2="B", arg3="C")
    "#{arg1} #{arg2} #{arg3}"
  end

  def test_variable_arguments
    assert_equal("1 ", variable_args(1))
    assert_equal("1 2", variable_args(1, 2))
    assert_equal("1 2,3", variable_args(1, 2, 3))
  end

  def variable_args(arg1, *rest)
    assert_equal(Array, rest.class)
    "#{arg1} #{rest.join(',')}"
  end

  def test_add_with_expanded_array_arguments
    assert_equal("1 2 3", three(1, 2, 3))
    assert_equal("1 2 3", three(1, *[2, 3]))
    assert_equal("1 2 3", three(*[1, 2, 3]))
    assert_equal("1 2 3", three(*(1..3).to_a))
  end

  def three(arg1, arg2, arg3)
    "#{arg1} #{arg2} #{arg3}"
  end

  def test_multiple_returns
    result = multiple_returns(1, 2, 3)
#    assert_equal(Values, result.class)
    assert_equal([1, [2, 3]], result)
  end

  def test_multiple_returns_with_parallel_assignment
    arg1, rest = multiple_returns(1, 2, 3)
    assert_equal(1, arg1)
    assert_equal([2, 3], rest)
  end

  def multiple_returns(arg1, *rest)
    return arg1, rest
  end
  
  def test_call_block
    y = call_block(2, 3) { |x, y| x * y }
    assert_equal(6, y)
  end

  def call_block(x, y, &block)
    block.call(x, y)
  end

  def test_call_proc
    calc = proc { |x| x * 2 }
    a = (1..5).collect(&calc)
    assert_equal([2, 4, 6, 8, 10], a)
  end

  def test_hash_argument_with_strings
    hash_argument("test", 
                  'key1' => 'value1',
                  'key2' => 'value2')
  end

  def hash_argument(arg1, hash)
    assert_equal(Hash, hash.class)
    assert_equal('value1', hash['key1'])
    assert_equal('value2', hash['key2'])
  end
  
end
