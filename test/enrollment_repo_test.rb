require_relative 'test_helper.rb'
require_relative '../lib/enrollment_repo.rb'
require_relative '../lib/enrollment.rb'
require 'csv'

class EnrollmentRepositoryTest < MiniTest::Test
	attr_reader :er

	def setup
		@er = EnrollmentRepository.new
			er.load_data({
  			:enrollment => {
    			:kindergarten => "./test/fixtures/kindergarteners_fixture.csv"
				}})
	end

		def test_it_is_a_enrollment_repo
			assert_equal EnrollmentRepository, er.class
		end

		def test_enrollment_repo_holds_enrollments
			assert_equal Enrollment, er.contents[0].class
		end

		def test_enrollments_in_repo_are_full
			assert_equal Hash, er.contents[0].kindergarten_participation_by_year.class
			refute er.contents[0].kindergarten_participation_by_year.empty?
		end

		def test_enrollments_return_nil_if_no_match
			assert_equal nil, er.find_by_name('frank')
		end

		def test_enrollment_can_find_named_object
			assert_equal "ACADEMY 20", er.find_by_name("ACADEMY 20").name
		end
		
		def test_enrollment_finder_is_case_insensitive
			assert_equal "ACADEMY 20", er.find_by_name("AcADemY 20").name
		end
end

