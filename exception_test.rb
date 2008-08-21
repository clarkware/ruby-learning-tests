#!/usr/bin/env ruby

require 'test/unit'

class ExceptionTest < Test::Unit::TestCase

  def test_no_exception
    assert_nothing_raised { true }
  end
  
  def test_raise_runtime_error
    assert_raise(RuntimeError) { raise "Bomb" }
  end
  
  def test_handle_runtime_error
    begin
      raise "Bomb"
      flunk "Should raise RuntimeError"
    rescue
      assert_equal(RuntimeError, $!.class)
      assert_equal("Bomb", $!.message)
    end
  end

  def test_reraise_runtime_error
    begin
      begin
        raise "Bomb"
        flunk "Should raise RuntimeError"
      rescue
        raise
      end
      flunk "Should raise RuntimeError"
    rescue
      assert_equal(RuntimeError, $!.class)
      assert_equal("Bomb", $!.message)      
    end
  end

  def test_raise_runtime_error_explicit
    begin
      raise RuntimeError, "Bomb"
      flunk "Should raise RuntimeError"
    rescue
      assert_equal(RuntimeError, $!.class)
      assert_equal("Bomb", $!.message)
    end
  end

  def test_custom_exception
    begin
      raise CustomException.new(13), "Bomb"
      flunk "Should raise CustomException"
    rescue CustomException => custom
      assert_equal(CustomException, custom.class)
      assert_equal("Bomb", custom.message)
      assert_equal(13, custom.code)
    end
  end
  
  def test_multiple_rescues
    begin
      raise CustomException.new(), "Bomb"
      flunk "Should raise CustomException"
    rescue CustomException => ex
      assert_equal(CustomException, ex.class)
    rescue RuntimeError => ex
      flunk "Should raise CustomException"
    end
  end
  
  def test_multiple_exceptions_one_rescue
    begin
      raise CustomException.new(), "Bomb"
      flunk "Should raise CustomException"
    rescue RuntimeError, CustomException => ex
      assert_equal(CustomException, ex.class)
    end
  end
  
  def test_ensure_with_exception_raised
    raised = false
    ensured = false
    begin
      raise RuntimeError
    rescue RuntimeError
      raised = true
    ensure
      ensured = true 
    end	
    assert(raised)
    assert(ensured)
  end
    
  def test_ensure_without_exception_raised
    ensured = false
    begin
    rescue RuntimeError
    ensure
      ensured = true 
    end
    assert(ensured)
  end

  def test_retry
    times = 2
    attempts = 0
    begin
      attempts += 1
      raise RuntimeError
    rescue RuntimeError
      retry if attempts < times 
    end	
    assert_equal(2, attempts)
  end

  def test_catch_throw
    x = 0
    catch (:done)  do
      for i in 1..10
        x = i
        throw :done unless i < 5
      end
      flunk "Should never get here"
    end
    assert_equal(5, x)
  end
    
end

class CustomException < RuntimeError

  attr :code
 
  def initialize(code = 0)
    @code = code
  end
end
