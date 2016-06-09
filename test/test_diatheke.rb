require 'test/unit'
require 'diatheke'

class TestDiatheke < Test::Unit::TestCase

  def test_mods
    mods = Diatheke.mods
    assert_include mods, 'KJV'
  end

  def test_passage
    res = Diatheke.passage('KJV', 'Joh 1:1-3')
    assert_equal ['John 1:1', 'John 1:2', 'John 1:3'], res.map {|e| e.key}
    assert_match /^In the beginning was the Word/, res.first.text
  end

  def test_search_phrase
    res = Diatheke.search('KJV', 'with God', :range => 'Joh 1')
    assert_equal ['John 1:1', 'John 1:2'], res
  end

  def test_search_multiword
    res = Diatheke.search('KJV', %w(God Jesus), :range => 'Joh 1')
    assert_equal ['John 1:29', 'John 1:36'], res
  end

  def test_search_regex
    res = Diatheke.search('KJV', /witness.+witness/, :range => 'Joh 1')
    assert_equal ['John 1:7'], res
  end

  def test_correct_split_with_colon_in_text
    res = Diatheke.passage('KJV', 'Joh 1:39').first
    assert_equal 'John 1:39', res.key
    text = 'He saith unto them, Come and see. They came and saw where he dwelt, and abode with him that day: for it was about the tenth hour.'
    assert_equal text, res.text
  end

  def test_correct_split_on_line_break_in_text
    res = Diatheke.passage('KJV', 'Joh 1:15')
    assert_equal ['John 1:15'], res.map {|r| r.key}
  end

end
