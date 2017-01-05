require_relative 'test_helper.rb'
require_relative '../lib/enrollment_repo.rb'
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
			assert_equal Enrollment, er.class
		end

