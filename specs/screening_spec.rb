require("minitest/autorun")
require('minitest/reporters')
require_relative('../models/screening.rb')

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

class TestScreening < MiniTest::Test

  def setup()
    @screening1 = Screening.new({'start_time' => '22:00:00',
                                'end_time' => '00:30:00',
                                'film_id' => 2,
                                'number_of_tickets' => 13})
  end

  def test_get_start_time()
    assert_equal('22:00:00', @screening1.start_time())
  end

  def test_get_end_time()
    assert_equal('00:30:00', @screening1.end_time())
  end

  def test_get_film_id()
    assert_equal(2, @screening1.film_id())
  end

  def test_get_number_of_tickets()
    assert_equal(13, @screening1.number_of_tickets())
  end

  def test_set_start_time()
    @screening1.start_time = '20:00:00'
    assert_equal('20:00:00', @screening1.start_time())
  end

  def test_set_end_time()
    @screening1.end_time = '23:00:00'
    assert_equal('23:00:00', @screening1.end_time())
  end

  def test_set_film_id()
    @screening1.film_id = 8
    assert_equal(8, @screening1.film_id())
  end

  def test_set_number_of_tickets()
    @screening1.number_of_tickets = 45
    assert_equal(45, @screening1.number_of_tickets())
  end

end
