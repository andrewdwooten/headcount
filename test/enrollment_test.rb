require_relative 'test_helper'
require './lib/enrollment.rb'
require './lib/enrollment_repository.rb'

class EnrollmentTest < MiniTest::Test
	attr_reader :e, :er

	def setup
		@e = Enrollment.new({:name => "ACADEMY 20",
		 :kindergarten => {
			 2010 => 0.3915, 2011 => 0.35356, 2012 => 0.2677}})
		@er = EnrollmentRepository.new
			er.load_data({
  			:enrollment => {
    			:kindergarten => "./test/fixtures/kindergarteners_fixture.csv",
    				:high_school_graduation => "./test/fixtures/high school gradrates fixture.csv"
  					}})
	end

		def test_it_is_an_enrollment
			assert Enrollment, e.class
		end

		def test_enrollment_knows_its_name
			assert_equal "ACADEMY 20", e.name
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

		def test_enrollment_can_return_hash_of_graduation_rates
			enr = er.find_by_name("academy 20")
			test = enr.graduation_rate_by_year
			assert_equal Hash, test.class
			assert_equal ({2010=>0.895, 2011=>0.895}), test
		end

		def test_enrollment_can_return_rate_in_year_of_graduation
			enr = er.find_by_name("academy 20")
			test = enr.graduation_rate_in_year(2010)
			assert_equal 0.895, test
		end
	end