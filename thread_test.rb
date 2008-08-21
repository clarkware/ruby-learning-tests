#!/usr/bin/env ruby

require 'test/unit'

class ThreadTest < Test::Unit::TestCase
  
  def test_main_thread
    main_thread = Thread.current
    assert_equal([main_thread], Thread.list)
    assert_equal("run", main_thread.status)
    assert_equal(true, main_thread.alive?)
    assert_equal(0, main_thread.priority)
  end
  
  def test_new_thread
    main_thread = Thread.current
    new_thread = nil
    t = Thread.new do
      new_thread = Thread.current
    end
    t.join
    assert_not_nil(new_thread)
    assert_not_equal(new_thread, main_thread)
  end

  def test_shared_local_variable
    local = 1
    t = Thread.new do 
      local *= 2
    end 
    t.join
    assert_equal(2, local)
  end

  def test_nonshared_local_variable
    local = 1
    t = Thread.new(local) do |copy_of_local|
      copy_of_local *= 2
    end
    t.join
    assert_equal(1, local)
  end

  def test_thread_local_variables
    threads = []
    3.times do |i|
      threads[i] = Thread.new do 
        Thread.current["my_count"] = i
      end 
    end
    threads.each { |thread| thread.join }
    
    assert_equal(0, threads[0]["my_count"])
    assert_equal(1, threads[1]["my_count"])
    assert_equal(2, threads[2]["my_count"])
  end

end