require("minitest/autorun")
require('minitest/reporters')
require_relative('../models/screen.rb')

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

class TestScreen < MiniTest::Test

  def setup()

    @screen1 = Screen.new({'name' => 'Screen 3',
                           'capacity' => 18})

  end

  def test_get_name()
    assert_equal('Screen 3', @screen1.name())
  end

  def test_get_capacity()
    assert_equal(18, @screen1.capacity())
  end

  def test_set_name()
    @screen1.name = 'Luxe Screen'
    assert_equal('Luxe Screen', @screen1.name())
  end

  def test_set_capacity()
    @screen1.capacity = 30
    assert_equal(30, @screen1.capacity())
  end

end
