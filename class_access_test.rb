#!/usr/bin/env ruby

require 'test/unit'

class ClassAccessTest < Test::Unit::TestCase
  
  def test_private_method
    begin
      c = Parent.new
      c.only_me
      flunk("Should raise NoMethodError")
    rescue NoMethodError
      assert(true)
    end
  end

  def test_protected_method
    begin
      c = Parent.new
      c.me_and_subclasses
      flunk("Should raise NoMethodError")
    rescue NoMethodError
      assert(true)
    end
  end

  def test_child_calls_parent_private
    c = Child.new
    c.call_parent_private
    assert(true)
  end

  def test_child_calls_parent_protected
    c = Child.new
    c.call_parent_protected
    assert(true)
  end
 
end


class Parent
  
  public

    def everybody
    end

    def everybody_2
    end

  protected

    def me_and_subclasses
    end

  private

    def only_me
    end

  # 
  # Alternative access control declarations:
  #
  public :everybody, :everybody_2
  protected :me_and_subclasses
  private :only_me
   
end

class Child < Parent

  def call_parent_private
    only_me
  end

  def call_parent_protected
    me_and_subclasses 
  end

end
