#!/usr/bin/env ruby

require 'test/unit'

class MetaprogramTest < Test::Unit::TestCase

  def test_method_send
    assert_equal(4, "mike".send(:length))
  end

  def test_method_call
    m = "Mike".method(:length)
    assert_equal(4, m.call)
  end

  def test_eval
    code = %q{"Mike".length}
    assert_equal(4, eval(code))
  end

  def test_new_class
    class_name = "Mike"
    mike_class = instance_eval %{Object::#{class_name} = Class.new(Object)}
    assert_kind_of Object, mike_class
  end

end
