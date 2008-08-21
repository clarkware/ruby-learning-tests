#!/usr/bin/env ruby

require 'test/unit'

class RegularExpressionTest < Test::Unit::TestCase

  def test_creation
    r1 = /Ruby/
    r2 = %r{Ruby}
    r3 = Regexp.new('Ruby')
    assert_match(r1, "Goodbye Ruby Tuesday")
    assert_match(r2, "Goodbye Ruby Tuesday")
    assert_match(r3, "Goodbye Ruby Tuesday")
  end

  def test_no_match
    assert_equal(nil, "Perl" =~ /Ruby/)
    assert_no_match(/Ruby/, "Perl")
  end
      
  def test_positive_match
    assert_equal(8, "Goodbye Ruby Tuesday" =~ /Ruby/)
    assert_match(/Ruby/, "Goodbye Ruby Tuesday")
  end

  def test_negative_match
    assert_equal(true, "abc" !~ /x/)
  end
  
  def test_begin_line_anchor
    regex = /^M/
    assert_match(regex, "Mike")
    assert_no_match(regex, "ikeM")
  end

  def test_end_line_anchor
    regex = /e$/
    assert_match(regex, "Mike")
    assert_no_match(regex, "Miek")
  end
  
  def test_alternation
    regex = /P(erl|ython)/
    assert_match(regex, "Python")
    assert_match(regex, "Perl")
  end

  def test_any_single_character
    regex = /Perl.Python/
    assert_match(regex, "Perl Python")
    assert_match(regex, "Perl-Python")
    assert_no_match(regex, "PerlPython")
  end

  def test_zero_or_more_repetition
    regex = /ab*c/
    assert_match(regex, "ac")
    assert_match(regex, "abc")
    assert_match(regex, "abbc")
  end

  def test_one_or_more_repetition
    regex = /ab+c/
    assert_no_match(regex, "ac")
    assert_match(regex, "abc")
    assert_match(regex, "abbc")
  end

  def test_zero_or_one_repetition
    regex = /ab?c/
    assert_match(regex, "ac")
    assert_match(regex, "abc")
    assert_no_match(regex, "abbc")
  end

  def test_at_least_m_repetition
    regex = /ab{1,}c/
    assert_no_match(regex, "ac")
    assert_match(regex, "abc")
    assert_match(regex, "abbc")
    assert_match(regex, "abbbc")
  end

  def test_exactly_m_repetition
    regex = /ab{2}c/
    assert_no_match(regex, "abc")
    assert_match(regex, "abbc")
    assert_no_match(regex, "abbbc")
  end

  def test_at_least_m_at_most_n_repetition
    regex = /ab{1,2}c/
    assert_no_match(regex, "ac")
    assert_match(regex, "abc")
    assert_match(regex, "abbc")
    assert_no_match(regex, "abbbc")
  end
  
  def test_in_character_class
    assert_equal(1, "Mike" =~ /[aeiou]/)
    assert_equal(5, "Mike Clark" =~ /[C-E]/)
    assert_equal(4, "Mike Clark" =~ /[\s]/)
    assert_equal(4, "Mike Clark" =~ /[[:space:]]/)
    assert_equal(5, "Mike 7" =~ /[0-9]/)
    assert_equal(5, "Mike 7" =~ /[\d]/)
    assert_equal(5, "Mike 7" =~ /[[:digit:]]/)
  end

  def test_not_in_character_class
    assert_equal(3, "Mike" =~ /[^Mik]/)
  end
  
  def test_character_class_abbreviations
    assert_equal(3, "abc1" =~ /\d/)  # digit
    assert_equal(3, "123a" =~ /\D/)  # non-digit
    assert_equal(1, "a bc" =~ /\s/)  # whitespace
    assert_equal(2, "  ab" =~ /\S/)  # non-whitespace
    assert_equal(2, "--ab" =~ /\w/)  # word
    assert_equal(2, "ab--" =~ /\W/)  # non-word
  end

  def test_match_side_effects
    assert_equal(3, "Ireland" =~ /l/)
    assert_equal("Ire", $`)
    assert_equal("l", $&)
    assert_equal("and", $')
    assert_equal(MatchData, $~.class)
    assert_equal(nil, $1)

    assert_equal("Ire<<l>>and", "#{$`}<<#{$&}>>#{$'}")
  end

  def test_special_character
    regex = /\?/
    assert_match(regex, "maybe?")
  end

  def test_word_boundary_anchor
    assert_equal(5, "This is" =~ /\bis/)
  end

  def test_non_word_boundary_anchor
    assert_equal(2, "This is" =~ /\Bis/)
  end
  
  def test_grouping
    regex = /(\d\d):(\d\d)(..)/
    assert_equal(0, "12:50am" =~ regex)
    assert_equal("12", $1)
    assert_equal("50", $2)
    assert_equal("am", $3)

    regex = /((\d\d):(\d\d))(..)/
    assert_equal(0, "12:50am" =~ regex)
    assert_equal("12:50", $1)
    assert_equal("12", $2)
    assert_equal("50", $3)
    assert_equal("am", $4)
  end  
  
  def test_match_data
    r = /(\d+):(\d+)/  # match a time hh:mm   
    assert_nil(r.match("xyz"))

    md = r.match("Time: 12:34am")    
    assert_equal(MatchData, md.class)
    assert_equal("12:34", md[0])         # == $&   
    assert_equal("12", md[1])            # == $1   
    assert_equal("34", md[2])            # == $2   
    assert_equal("Time: ", md.pre_match) # == $`   
    assert_equal("am", md.post_match)    # == $'   
  end

  def test_first_occurrence_substition
    s = "abcdef"
    s.sub!(/abc/, '123')
    assert_equal("123def", s)
  end

  def test_every_occurrence_substition
    s = "abcdefabc"
    s.gsub!(/abc/, '123')
    assert_equal("123def123", s)
  end

end