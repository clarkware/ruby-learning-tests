#!/usr/bin/env ruby

require 'test/unit'

class MixinTest < Test::Unit::TestCase

  def test_custom_mixin
    p = Person.new
    assert_equal("Person", p.who_am_i?) 
  end

  def test_comparable_mixin
    one_dollar = Money.new(1.0)
    five_dollars = Money.new(5.0)
    
    assert_equal(-1, one_dollar <=> five_dollars)
    assert_equal(true, one_dollar < five_dollars)
    assert_equal(true, one_dollar == one_dollar)
    assert_equal(false, one_dollar > five_dollars)
  end
  
end

module Awareness
  def who_am_i?
    "#{self.class.name}"
  end
end

class Person
  include Awareness
end

class Money
  
  attr_reader :value
  
  include Comparable
  
  def initialize(value)
    @value = value
  end
  
  def <=>(other)
    self.value <=> other.value
  end
  
end
