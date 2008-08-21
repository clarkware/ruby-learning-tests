#!/usr/bin/env ruby

require 'test/unit'

class ReflectionTest < Test::Unit::TestCase

  def test_live_objects
    a = 102.7
    b = 95.1
    results = Array.new
 
    ObjectSpace.each_object(Numeric) {|x| results.push(x) }
    
    assert(results.length > 2)
    assert(results.include?(a))
    assert(results.include?(b))
  end
  
  def test_methods
    string = "mike"
    methods = string.methods  
    assert(methods.length > 0)
    assert(methods.include?("strip"))
    assert(!methods.include?("foo"))
  end

  def test_responds_to
    string = "mike"
    assert(string.respond_to?("strip"))  
    assert(!string.respond_to?("foo"))  
  end
  
  def test_class_info
    num = 1  
    assert_equal(3, num.object_id)
    assert_equal(Fixnum, num.class)
    assert(num.kind_of?(Fixnum))
    assert(num.kind_of?(Numeric))
    assert(num.instance_of?(Fixnum))
    assert(!num.instance_of?(Numeric))
  end
  
  def test_class_hierarchy
    klass = Fixnum
    classes = Array.new
    begin
      classes.push(klass)
      klass = klass.superclass
    end while klass
    
    assert_equal([Fixnum, Integer, Numeric, Object], classes)
  end

  def test_superclasses_and_mixins
    assert_equal([Fixnum, Integer, Precision, Numeric, Comparable, Object, Kernel], Fixnum.ancestors)
  end

  def test_methods_by_access_level
    assert_equal(["private_method"], Demo.private_instance_methods(false))
    assert_equal(["protected_method"], Demo.protected_instance_methods(false))
    assert_equal(["public_method"], Demo.public_instance_methods(false))
    assert_equal(["class_method"], Demo.singleton_methods(false))
    assert_equal(["CONST"], Demo.constants - Demo.superclass.constants) 
  end
    	
end

class Demo  
  private  
    def private_method  
    end  
  protected  
    def protected_method  
    end  
  public  
    def public_method  
    end  
 
  def Demo.class_method  
  end  
 
  CONST = ""  
end  
