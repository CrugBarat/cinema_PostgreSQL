require("minitest/autorun")
require('minitest/reporters')
require_relative('../models/film.rb')

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

class TestFilm < MiniTest::Test

  def setup()
    @film1 = Film.new({'title' => 'Frozen',
                       'genre' => 'Animation',
                       'price' => 5.50,
                       'rating' => 'U',
                       'screen_id' => 1})
  end

  def test_get_title()
    assert_equal('Frozen', @film1.title())
  end

  def test_get_genre()
    assert_equal('Animation', @film1.genre())
  end

  def test_get_price()
    assert_equal(5.50, @film1.price())
  end

  def test_get_rating()
    assert_equal('U', @film1.rating())
  end

  def test_get_screen_id()
    assert_equal(1, @film1.screen_id())
  end

  def test_set_title()
    @film1.title = 'Toy Story'
    assert_equal('Toy Story', @film1.title())
  end

  def test_set_genre()
    @film1.genre = 'Cartoon'
    assert_equal('Cartoon', @film1.genre())
  end

  def test_set_price()
    @film1.price = 8.00
    assert_equal(8.00, @film1.price())
  end

  def test_set_rating()
    @film1.rating = 'PG'
    assert_equal('PG', @film1.rating())
  end

  def test_set_screen_id()
    @film1.screen_id = 2
    assert_equal(2, @film1.screen_id())
  end

end
