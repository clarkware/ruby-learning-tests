#!/usr/bin/env ruby

require 'test/unit'

class InheritanceTest < Test::Unit::TestCase
  
  def setup
    @song = Song.new("Ruby Tuesday", "Matz", 123)
    @karaokeSong = KaraokeSong.new("Ruby Tuesday", "Matz", 123, "Goodbye...")
  end
  
  def test_superclass
    assert_equal("Ruby Tuesday-Matz (123)", @song.to_s)
  end

  def test_subclass
    assert_equal(KaraokeSong, @karaokeSong.class)
    assert_equal("Ruby Tuesday-Matz (123) [Goodbye...]", @karaokeSong.to_s)
  end
  
end

class Song
  
  def initialize(name, artist, duration)
    @name = name
    @artist = artist
    @duration = duration
  end
  
  def to_s
    "#@name-#@artist (#@duration)"
  end
  
end

class KaraokeSong < Song
  
  def initialize(name, artist, duration, lyrics)
    super(name, artist, duration)
    @lyrics = lyrics
  end
  
  def to_s
    super + " [#@lyrics]"
  end
  
end