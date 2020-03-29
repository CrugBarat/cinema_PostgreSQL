require("minitest/autorun")
require('minitest/reporters')
require_relative('../models/customer.rb')
require_relative('../models/film.rb')

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

class TestCustomer < MiniTest::Test

  def setup()
    @customer1 = Customer.new({'first_name' => 'John',
                               'last_name' =>'Doe',
                               'funds' => 45.00,
                               'fav_genre' => 'Action'})

    @film1 = Film.new({'title' => 'Frozen',
                       'genre' => 'Animation',
                       'price' => 5.50,
                       'rating' => 'U',
                       'screen_id' => 1})
  end

  def test_get_first_name()
    assert_equal('John', @customer1.first_name())
  end

  def test_get_last_name()
    assert_equal('Doe', @customer1.last_name())
  end

  def test_get_funds()
    assert_equal(45, @customer1.funds())
  end

  def test_get_fav_genre()
    assert_equal('Action', @customer1.fav_genre())
  end

  def test_set_first_name()
    @customer1.first_name = 'David'
    assert_equal('David', @customer1.first_name())
  end

  def test_set_last_name()
    @customer1.last_name = 'Smith'
    assert_equal('Smith', @customer1.last_name())
  end

  def test_set_funds()
    @customer1.funds = 25
    assert_equal(25, @customer1.funds())
  end

  def test_set_fav_genre()
    @customer1.fav_genre = 'Sci-Fi'
    assert_equal('Sci-Fi', @customer1.fav_genre())
  end

  def test_has_funds?()
    assert_equal(true, @customer1.has_funds?(@film1))
  end

end
