#!/usr/bin/env ruby

require 'test/unit'

class PrivateConstructorTest < Test::Unit::TestCase
  
  def test_create_square_with_area
    s = Square.with_area(4)
    assert_equal(2, s.side())
  end

  def test_create_square_with_diagonal
    s = Square.with_diagonal(2.828427)
    assert_in_delta(2, s.side(), 0.1)
  end

  def test_create_square_with_side
    s = Square.with_side(2)
    assert_equal(2, s.side())
  end
  
end

class Square
  
  private_class_method :new
  
  attr_reader :side
  
  def initialize(side)
    @side = side
  end
  
  def Square.with_area(area)
    new(Math.sqrt(area))
  end
  
  def Square.with_diagonal(diag)
    new(diag / Math.sqrt(2))
  end
  
  def Square.with_side(side)
    new(side)
  end
  
end