#!/usr/bin/env ruby

require 'test/unit'

require 'net/http'

class WebTest < Test::Unit::TestCase

  def test_scrape_images
    h = Net::HTTP.new('localhost', 80) 
    response = h.get('/index.html', nil) 
    assert_equal("OK", response.message)
    images = response.body.scan(/<img src="(.*?)"/).uniq
    assert_equal(["apache_pb.gif"], images[0])
  end

  def test_open
    require 'open-uri'
    page = open('http://localhost:80').read
    assert(page =~ /<img src="(.*?)"/)
  end

  def test_file_read
    require 'open-uri'
    images = []
    open('http://localhost:80') do |f| 
      images = f.read.scan(/<img src="(.*?)"/).uniq 
    end
    assert_equal(["apache_pb.gif"], images[0])
  end

end
