require("minitest/autorun")
require('minitest/reporters')
require_relative('../models/screen.rb')

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

class TestScreen < MiniTest::Test

end
