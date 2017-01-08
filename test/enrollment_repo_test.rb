require_relative 'test_helper.rb'
require_relative '../lib/enrollment_repo.rb'
require_relative '../lib/enrollment.rb'

class EnrollmentRepositoryTest < MiniTest::Test
	attr_reader :er, :er2

	def setup
		@er = EnrollmentRepository.new
			er.load_data({
  			:enrollment => {
    			:kindergarten => "./test/fixtures/kindergarteners_fixture.csv"
				}})
		@er2 = EnrollmentRepository.new
			er2.load_data({
  			:enrollment => {
    			:kindergarten => "./test/fixtures/kindergarteners_fixture.csv",
    				:high_school_graduation => "./test/fixtures/high school gradrates fixture.csv"
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
			assert_nil er.find_by_name('frank')
		end

		def test_enrollment_can_find_named_object
			assert_equal "ACADEMY 20", er.find_by_name("ACADEMY 20").name
		end
		
		def test_enrollment_finder_is_case_insensitive
			assert_equal "ACADEMY 20", er.find_by_name("AcADemY 20").name
		end

		def test_enrollment_repo_accepts_data_from_additional_file
			enrollment = er2.find_by_name("Academy 20")
			assert_equal 3, enrollment.name_stats.keys.count
			assert enrollment.name_stats.has_key?(:high_school_graduation)
			assert_equal Hash, enrollment.name_stats[:high_school_graduation].class
			refute enrollment.name_stats[:high_school_graduation].empty?
		end
end

