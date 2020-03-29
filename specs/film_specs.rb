require("minitest/autorun")
require('minitest/reporters')
require_relative('../models/film.rb')

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

class TestFilm < MiniTest::Test

end
