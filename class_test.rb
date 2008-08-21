#!/usr/bin/env ruby

require 'test/unit'

class ClassTest < Test::Unit::TestCase
  
  def setup
    @song = Song.new("Ruby Tuesday", "Matz", 123)
  end
  
  def test_class
    assert_equal(Song, @song.class)  
    assert(@song.object_id > 0)
    assert_equal("Ruby Tuesday-Matz (123)", @song.to_s)
  end
  
  def test_read_only_attributes
    assert_equal("Ruby Tuesday", @song.name)
    assert_equal("Matz", @song.artist)
  end
  
  def test_read_write_attributes
    assert_equal(123, @song.duration)
    @song.duration = 456
    assert_equal(456, @song.duration)
  end
  
  def test_class_method
    assert_equal(0, Song.total_plays)
    assert_equal(1, @song.play)
    assert_equal(1, Song.total_plays)
    
    anotherSong = Song.new("Title", "Artist", 10)
    assert_equal(1, anotherSong.play)
    assert_equal(2, Song.total_plays)
  end

  def test_dup
    song2 = @song.dup
    assert_not_equal(song2, @song)
    assert_not_equal(song2.object_id, @song.object_id)
  end

  def test_freeze
    begin
      song2 = @song
      @song.freeze
      song2.duration = 123
      flunk("Should raise TypeError")
    rescue TypeError => error
      assert_equal("can't modify frozen object", error.message)
    end
  end
  
  class Song
  
    attr_reader :name, :artist, :duration
    attr_writer :duration
  
    @@totalPlays = 0
  
    def initialize(name, artist, duration)
      @name = name
      @artist = artist
      @duration = duration
      @plays = 0
    end

    def duration
      @duration
    end
 
    def duration=(duration)
      @duration = duration
    end
  
    def play
      @plays += 1
      @@totalPlays += 1
      return @plays
    end
  
    def self.total_plays
      @@totalPlays
    end

    def to_s
      "#@name-#@artist (#@duration)"
    end
    
  end  
  
end
