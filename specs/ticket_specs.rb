require("minitest/autorun")
require('minitest/reporters')
require_relative('../models/ticket.rb')

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

class TestTicket < MiniTest::Test

end
