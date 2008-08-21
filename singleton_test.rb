#!/usr/bin/env ruby

require 'test/unit'

class SingletonTest < Test::Unit::TestCase
  
  def test_custom_singleton
    a = MySingleton.create
    b = MySingleton.create
    assert_equal(a.object_id, b.object_id)
  end

  def test_mixin_singleton
    a = MySingletonMixin.instance
    b = MySingletonMixin.instance
    assert_equal(a.object_id, b.object_id)
  end
  
end

# Not thread-safe!

class MySingleton

  private_class_method :new

  @@instance = nil

  def MySingleton.create
    @@instance = new unless @@instance
    @@instance
  end

end

# A thread-safe alternative to a custom singleton.

require 'singleton'

class MySingletonMixin
  include Singleton
end
