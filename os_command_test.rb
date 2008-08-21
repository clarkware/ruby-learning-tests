#!/usr/bin/env ruby

require 'test/unit'

class OSCommandTest < Test::Unit::TestCase
  
  def test_literal
    result = `date`
    assert_equal(0, exitStatus = $?)
    regex = /(\d+):(\d+):(\d+)/ 
    assert_match(regex, result)
  end

  def test_delimited_literal
    result = %x{ date }
    assert_equal(0, exitStatus = $?)
    regex = /(\d+):(\d+):(\d+)/ 
    assert_match(regex, result)
  end

  def test_expand_expression
    for i in 0..3
      result = `echo #{i}`
      assert_equal(0, exitStatus = $?)
      assert_equal(i.to_s, result.chomp)
    end
  end

  def test_override_backquote
    alias old_backquote `
    def `(cmd)
      result = old_backquote(cmd)
      if $? != 0
        fail "Command #{cmd} failed: #$?"
      end
      result
    end

    `date`
    assert_equal(0, exitStatus = $?)
  end

end
