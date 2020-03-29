require("minitest/autorun")
require('minitest/reporters')
require_relative('../models/ticket.rb')

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

class TestTicket < MiniTest::Test

  def setup()
    @ticket1 = Ticket.new({'customer_id' => 5,
                          'screening_id' => 8})
  end

  def test_get_customer_id()
    assert_equal(5, @ticket1.customer_id())
  end

  def test_get_screening_id()
    assert_equal(8, @ticket1.screening_id())
  end

  def test_set_customer_id()
    @ticket1.customer_id = 23
    assert_equal(23, @ticket1.customer_id())
  end

  def test_set_screening_id()
    @ticket1.screening_id = 11
    assert_equal(11, @ticket1.screening_id())
  end

end
