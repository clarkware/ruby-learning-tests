#!/usr/bin/env ruby

require 'test/unit'

class HashTest < Test::Unit::TestCase

  def test_new_hash_literal
    h = {
      :key1 => 'value1',
      :key2 => 'value2'
    }
    
    assert_equal(Hash, h.class)
    assert_equal(2, h.length)
    assert_equal({:key1 => "value1", :key2 => "value2"}, h)
  end

  def test_new_hash
    h = Hash.new
    h[:key1] = 'value1'
    h[:key2] = 'value2'

    assert_equal(Hash, h.class)    
    assert_equal(2, h.length)
    assert_equal({:key1 => "value1", :key2 => "value2"}, h)
  end

  def test_new_hash_with_default_value
    h = Hash.new(0)
    assert_equal(0, h['unknown_key'])
  end

  def test_indexing
    h = {
      :key1 => 'value1',
      :key2 => 'value2'
    }
    assert_equal('value1', h[:key1])
    assert_equal('value2', h[:key2])
    assert_nil(h[:key3])
  end

  def test_assignment
    h = { :key1 => 'value1' }
    assert_equal('value1', h[:key1])
    h[:key1] = 'newValue1'
    assert_equal('newValue1', h[:key1])
    h[12] = 'canine'
    assert_equal('canine', h[12])
  end

  def test_iterator
    h = {
      "key1" => 'value1',
      "key2" => 'value2'
    }
    
    i = 1
    for key, value in h
      assert_equal("key#{i}", key)
      assert_equal("value#{i}", value)
      i = i + 1
    end
  end
    
end
