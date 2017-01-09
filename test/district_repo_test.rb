require_relative 'test_helper.rb'
require './lib/district_repo.rb'

class DistrictRepoTest < MiniTest::Test

	attr_reader :dr, :dr2

	def setup
		@dr = DistrictRepository.new
			dr.load_data({
  			:enrollment => {
    			:kindergarten => "./test/fixtures/kindergarteners_fixture.csv"
				}})
		@dr2 = DistrictRepository.new
	end

		def test_it_is_a_district_repo
			assert_equal DistrictRepository, dr.class
		end

		def test_district_repo_will_accept_data
			dr_contents = dr.contents
			assert_equal Array, dr_contents.class
			assert_equal District, dr_contents[0].class
		end

		def test_district_repo_can_find_district_by_name
			assert_equal District, dr.find_by_name("ACADEMY 20").class #need to modify test to assess district attribute
		end

		def test_district_repo_returns_empty_array_if_no_partial_match
			assert_equal [], dr.find_all_matching('zzz')
		end

		def test_district_repo_returns_array_of_districts_if_partial_matches
			search_results = dr.find_all_matching('Aca')
			assert_equal Array, search_results.class
			assert_equal District, search_results[0].class
		end

		def test_on_instantiation_districtrepo_has_an_empty_enrollment_repo
			assert_equal EnrollmentRepository, dr2.enrollment.class
			assert dr2.enrollment.contents.empty?
		end

		def test_on_loading_data_the_dr_generates_loads_enrollment_repo
			assert_equal EnrollmentRepository, dr.enrollment.class
			refute dr.enrollment.contents.empty?
		end

		def test_district_repo_districts_have_relationship_with_enrollment
			district = dr.find_by_name("Academy 20")
			assert_equal 0.391, district.enrollment.kindergarten_participation_in_year("2007")
		end
	end

