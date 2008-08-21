#!/usr/bin/env ruby

require 'test/unit'

class StringTest < Test::Unit::TestCase
  
  def test_single_quoted_literal
    assert_equal("escape using \\", 'escape using \\')
    assert_equal("that's right", 'that\'s right')
  end
  
  def test_length
    assert_equal(4, "Mike".length)
  end

  def test_substring
    s = "Mike"
    assert_equal("ik", s[offset=1, length=2])
    assert_equal("ike", s[offset=1, length=99])
    assert_equal("ik", s[1..2])
    assert_equal("ik", s["ik"])
  end
  
  def test_index
    assert_equal(2, "Mike".index('k'))
    assert_equal(nil, "Mike".index('z'))
  end
  
  def test_concatenation
    assert_equal("Hello, Mike", "Hello, " + "Mike")
    assert_equal("Hello, Mike", "Hello, " << "Mike")
  end

  def test_expression_substitution
    assert_equal("Ho! Ho! Ho! ", "#{'Ho! ' * 3}")
  end
  
  def test_multi_statement_expression_substitution
    s = "#{ def hello(message)
              'Hello, ' + message
            end
            hello('world')
          }!"
    assert_equal("Hello, world!", s)
  end

  def test_here_document
    s = <<-END_OF_STRING
  	   multi-line text
  	END_OF_STRING
    assert_equal("multi-line text", s.strip)
  end
    
  def test_split_default
    s = "name age ssn"
    words = s.split
    assert_equal("name", words[0])
    assert_equal("age", words[1])
    assert_equal("ssn", words[2])
  end
  
  def test_split_on_regex
    s = "name | age | ssn"
    name, age, ssn = s.split(/\s*\|\s*/)
    assert_equal("name", name)
    assert_equal("age", age)
    assert_equal("ssn", ssn)
  end
  
  def test_scan
    s = "12:48"
    hour, minute = s.scan(/\d+/)
    assert_equal("12", hour)
    assert_equal("48", minute)
  end
  
  def test_squeeze
    s = "a   b   c"
    s.squeeze!(" ")
    assert_equal("a b c", s)
  end

  def test_chop
    s = "Mikey"
    assert_equal("Mike", s.chop)
  end

  def test_chomp
    s = "Mikey"
    assert_equal("Mikey", s.chomp)
    s = "Mikey\n"
    assert_equal("Mikey", s.chomp)
    s = "Mikey"
    assert_equal("Mike", s.chomp("y"))
  end

  def test_strip
    s = "\tMike  \r\n"
    assert_equal("Mike", s.strip)
  end
  
  def test_justify
    s = "Mike"
    assert_equal("Mike  ", s.ljust(6))
    assert_equal("  Mike", s.rjust(6))
    assert_equal(" Mike ", s.center(6)) 
  end

  def test_case
    assert_equal("mike", "MIKE".downcase)
    assert_equal("MIKE", "mike".upcase)
    assert_equal("Mike", "mike".capitalize)
  end
  
  def test_substitute_one_occurrence
    s = "the quick brown fox"    
    s.sub!(/[aeiou]/,  '*')
    assert_equal("th* quick brown fox", s)    
  end
    
  def test_substitute_every_occurrence
    s = "the quick brown fox"
    s.gsub!(/[aeiou]/, '*')
    assert_equal("th* q**ck br*wn f*x", s)
  end
    
  def test_substitute_with_block
    a = "the quick brown fox"
    a.gsub!(/\b\w/) { |first_letter| first_letter.upcase }
    assert_equal("The Quick Brown Fox", a)
  end

  def test_include
    s = "Mike"
    assert_equal(true, s.include?("i"))
    assert_equal(false, s.include?("t"))
  end

  def test_each_byte
    s = "abc"
    count = 0
    s.each_byte { |c| count += 1 }
    assert_equal(3, count)
  end

  def test_each_line
    s = "a\n b\n c\n"
    count = 0
    s.each { |c| count += 1 }
    assert_equal(3, count)
  end
  
  def test_number_bases
    assert_equal(13, "15".oct)
    assert_equal(0, "Z".oct)
  end

end