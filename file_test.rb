#!/usr/bin/env ruby

require 'test/unit'

class IOTest < Test::Unit::TestCase
  
  TEST_FILE = "testfile"

  def teardown
    File.delete(TEST_FILE) if File.exist?(TEST_FILE)
  end
  
  def test_new_file
    f = File.new(TEST_FILE, "w")
    assert(File.exist?(TEST_FILE))
    assert_equal(TEST_FILE, f.path)
    f.close()
    assert(f.closed?)
  end
  
  def test_create_and_open_file
    file = nil
    File.open(TEST_FILE, "w") do |file|
      assert_equal(TEST_FILE, file.path)
    end
    assert(file.closed?)
  end
  
  def test_readline
    File.open(TEST_FILE, "w+") do |file|
      file.print("ABC\nDEF")
      file.rewind()
      assert_equal("ABC\n", file.readline())
      assert_equal("DEF", file.readline())
    end
  end
  
  def test_each_line
    File.open(TEST_FILE, "w+") do |file|
      file.print("ABC\nDEF\n")
      file.rewind()
      lines = []
      file.each_line do |line|
        lines << line
      end
      assert_equal(["ABC\n", "DEF\n"], lines)	
    end
  end

  def test_each_line_with_separator
    File.open(TEST_FILE, "w+") do |file|
      file.print("ABC.DEF.")
      file.rewind()
      lines = []
      file.each_line('.') do |line|
        lines << line
      end
      assert_equal(["ABC.", "DEF."], lines)	
    end
  end

  def test_each_byte
    File.open(TEST_FILE, "w+") do |file|
      file.print("ABC")
      file.rewind()
      bytes = []
      file.each_byte { |x| bytes << x } 
      assert_equal([65, 66, 67], bytes)
    end
  end
  
  def test_for_each
    File.open(TEST_FILE, "w") do |file|
      file.print("ABC\nDEF\n")
      file.rewind()
    end

    lines = []
    IO.foreach(TEST_FILE) do |line|
      lines << line
    end
    assert_equal(["ABC\n", "DEF\n"], lines)	
  end

  def test_read_file_into_string
    File.open(TEST_FILE, "w") do |file|
      file.print("ABC\nDEF\n")
      file.rewind()
    end
    s = IO.read(TEST_FILE)
    assert_equal(8, s.length)
    assert_equal("ABC\nDEF\n", s[0, 8])
  end

  def test_read_file_into_array
    File.open(TEST_FILE, "w") do |file|
      file.print("ABC\nDEF\n")
      file.rewind()
    end
    a = IO.readlines(TEST_FILE)
    assert_equal(2, a.length)
    assert_equal("ABC\n", a[0])
    assert_equal("DEF\n", a[1])
  end
  
  def test_stringio
    
    require 'stringio'

    ip = StringIO.new("abc")
    op = StringIO.new("", "w")
    
    ip.each_line do |line|
      op.puts line.reverse
    end

    assert_equal("cba\n", op.string)
  end

end
