require_relative 'test_helper'
require './lib/statewidetest.rb'
require './lib/statewidetest_repository.rb'

class StatewideTest < MiniTest::Test
  def setup
    @s = StatewideTest.new
	end

	def test_it_is_a_statewide_test
		assert StatewideTest, e.class
	end