#!/usr/bin/env ruby

require 'test/unit'

require 'rss/2.0'

class RSSTest < Test::Unit::TestCase

  TEST_FILE = "test.rss"

  def teardown
    File.delete(TEST_FILE) if File.exist?(TEST_FILE)
  end

  def test_create_feed
    rss = RSS::Rss.new("2.0")
    channel = RSS::Rss::Channel.new
    channel.title = channel.description = "Test Channel"
    rss.channel = channel
    
    item = RSS::Rss::Channel::Item.new
    item.title =  "Test Item"
    item.pubDate = Time.now
    item.description = "Test Description"
    
    channel.items << item

    File.open(TEST_FILE, "w") { |f| f.puts(rss.to_s) }

    feed = RSS::Parser.parse(File.read(TEST_FILE), false)

    assert_equal(rss.channel.title, feed.channel.title)
    assert_equal(1, feed.channel.items.length)
  end
end
