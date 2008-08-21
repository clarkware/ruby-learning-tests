#!/usr/bin/env ruby

require 'test/unit'

class MethodMissingTest < Test::Unit::TestCase

  def test_method_missing
    foo(1, 'a')
    assert_equal("foo", @name)
    assert_equal([1, 'a'], @args)
  end
  
  def method_missing(method_symbol, *method_args)
    @name = method_symbol.id2name
    @args = method_args
  end
  
end
