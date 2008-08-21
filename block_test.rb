#!/usr/bin/env ruby

require 'test/unit'

class BlockTest < Test::Unit::TestCase
  	
  def test_call_block_twice
    x = 0
    call_block_twice { x += 1 }
    assert_equal(2, x)
  end
  
  def call_block_twice
    yield
    yield
  end
    
  def test_call_block_with_one_parameter
    x = 0
    call_block_with_one_param(1) { |y| x = y  }
    assert_equal(1, x)
  end
  
  def call_block_with_one_param(y)
    yield y
  end
  
  def test_call_block_with_two_params
    z = 0
    call_block_with_two_params(1, 2) { |x, y| z = x + y }
    assert_equal(3, z)
  end

  def call_block_with_two_params(x, y)
    yield x, y
  end

  def test_call_block_with_unchanged_local_variable
    x = 0
    call_block_with_unchanged_local { |y| x = y = y+1 }
    assert_equal(2, x)
  end

  def call_block_with_unchanged_local
    y = 1
    yield y
    assert_equal(1, y)
  end
  
  def test_block_given
    b = take_block("no block")
    assert_equal(false, b)
    
    b = take_block("block") { |param| param }
    assert_equal(true, b)
  end
  
  def take_block(param)
    if block_given?
      yield true
    else
      false
    end
  end
  
  def test_proc
    y = 0
    call_proc(1) { |x| y = x }
    assert_equal(1, y)
  end
  
  def call_proc(x, &action)
    action.call(x)
  end
  
  def test_closure
    p = n_times(2)
    assert_equal(4, p.call(2))
    assert_equal(6, p.call(3))
  end
  
  def n_times(thing)
    return proc { |n| thing * n }
  end
  
end
