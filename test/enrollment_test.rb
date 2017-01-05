require_relative 'test_helper'
require './lib/enrollment.rb'

class EnrollmentTest < MiniTest::Test
	attr_reader :e

	def setup
		@e = Enrollment.new({:name => "ACADEMY 20",
		 :kindergarten_participation => {
			 2010 => 0.3915, 2011 => 0.35356, 2012 => 0.2677}})
	end

		def test_it_is_an_enrollment
			assert Enrollment, e.class
		end

		def test_enrollment_holds_partic_in_k_in_hash
			assert Hash, e.kindergarten_participation_by_year
			assert [2010, 2011, 2012], e.kindergarten_participation_by_year.keys
			assert [0.391, 0.353, 0.267], e.kindergarten_participation_by_year.values
		end

		def test_enrollment_can_return_part_in_a_year
			assert 0.391, e.kindergarten_participation_in_year(2010)
			assert 0.353, e.kindergarten_participation_in_year(2011)
			assert 0.267, e.kindergarten_participation_in_year(2012)
		end
	end