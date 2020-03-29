require("minitest/autorun")
require('minitest/reporters')
require_relative('../models/screening.rb')

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

class TestScreening < MiniTest::Test

end
