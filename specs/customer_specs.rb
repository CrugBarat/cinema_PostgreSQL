require("minitest/autorun")
require('minitest/reporters')
require_relative('../models/customer.rb')

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

class TestCustomer < MiniTest::Test

end
