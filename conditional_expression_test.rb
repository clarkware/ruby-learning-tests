#!/usr/bin/env ruby

require 'test/unit'

class ConditionalExpressionTest < Test::Unit::TestCase
  
  def test_boolean_true
    assert(true)
    assert(1)
    assert(0)
    assert("")
  end

  def test_boolean_false
    assert(!nil)
    assert(!false)
  end

  def test_and
    assert(true && true)
  end

  def test_or
    assert(true || false)
  end

  def test_not
    assert(!false)
  end

  def test_defined?
    assert_equal(nil, defined? dummy)
    assert_equal("expression", defined? 1)
    assert_equal("method", defined? puts)
    assert_equal("constant", defined? String)
    assert_equal("global-variable", defined? $_)
    assert_equal("assignment", defined? a=1)
  end

  def test_equal_value
    a = "a"
    b = "a" 
    assert(a == b)
  end

  def test_equal?
    a = "a"
    b = "a"
    assert_equal(false, a.equal?(b))
  end

  def test_eql?
    a = "a"
    b = "a"
    assert_equal(true, a.eql?(b))
  end

  def test_if
    assert_equal("Yes", if_greater_than_five(6))
    assert_equal("No", if_greater_than_five(5))
  end

  def if_greater_than_five(x)
    if x > 5 then "Yes"
    else "No"
    end
  end

  def test_unless
    assert_equal("Yes", unless_greater_than_five(6))
    assert_equal("No", unless_greater_than_five(5))
  end

  def unless_greater_than_five(x)     
    unless x > 5 then "No"
    else "Yes"
    end
  end

  def test_if_modifier
    x = 6
    y = x if x > 5
    assert_equal(6, y)
  end

  def test_unless_modifier
    x = 6
    y = x unless x > 5
    assert_equal(nil, y)
  end

  def test_case
    assert_equal(false, leap_year?(1970)) 
    assert_equal(true, leap_year?(400))
  end

  def leap_year?(year)
    leap = case year
           when year % 400 == 0: true 
           when year % 100 == 0: false 
           else year % 4 == 0
    end
  end

end
