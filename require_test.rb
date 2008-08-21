#!/usr/bin/env ruby

require 'test/unit'

class RequireTest < Test::Unit::TestCase
  
  def test_load_path
    load_path = $:
    assert_equal(Array, load_path.class)
    assert(load_path.length > 0)
    assert(load_path.member?("."))
  end
  
  def test_loaded_files
    loaded_files = $"
    assert_equal(Array, loaded_files.class)
    assert(loaded_files.length > 0)
    assert(loaded_files.member?("test/unit.rb"))
  end
  
  def test_require
    assert_equal(true, require("matrix"))
    assert_equal(false, require("matrix")) # already required
  end
  
  def test_load
    assert_equal(true, load("require_test.rb"))
    assert_equal(true, load("require_test.rb")) 
  end
  
  def test_reload
    5.times do |i|
      File.open("temp.rb", "w") do |f|
        f.puts("module Temp")
        f.puts("  def Temp.var")
        f.puts("    #{i} ")
        f.puts("  end")
        f.puts("end")
      end
      load "temp.rb"
      assert_equal(i, Temp.var)
    end
    assert(File.delete("temp.rb"))
  end
  
end
