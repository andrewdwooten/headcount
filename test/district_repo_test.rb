require_relative 'test_helper.rb'
require './lib/district_repository.rb'

class DistrictRepoTest < MiniTest::Test

	attr_reader :dr, :dr2, :dr3, :dr4

	def setup
		@dr = DistrictRepository.new
			dr.load_data({
  			:enrollment => {
    			:kindergarten => "./test/fixtures/kindergarteners_fixture.csv"
				}})
		@dr2 = DistrictRepository.new
		@dr3 = DistrictRepository.new
			dr3.load_data({
  :enrollment => {
    :kindergarten => "./data/Kindergartners in full-day program.csv",
    :high_school_graduation => "./data/High school graduation rates.csv",
  },
  :statewide_testing => {
    :third_grade => "./test/fixtures/3rdgrdproficient_fixture.csv",
    :eighth_grade => "./test/fixtures/8thgrdproficient_fixture.csv",
    :math => "./test/fixtures/math_by_race_fixture.csv",
    :reading => "./test/fixtures/reading_by_race_fixture.csv",
    :writing => "./test/fixtures/writing_by_race_fixture.csv"}})

		@dr4 = DistrictRepository.new
			dr4.load_data({
  :enrollment => {
    :kindergarten => "./data/Kindergartners in full-day program.csv",
    :high_school_graduation => "./data/High school graduation rates.csv",
  },
  :statewide_testing => {
    :third_grade => "./test/fixtures/3rdgrdproficient_fixture.csv",
    :eighth_grade => "./test/fixtures/8thgrdproficient_fixture.csv",
    :math => "./test/fixtures/math_by_race_fixture.csv",
    :reading => "./test/fixtures/reading_by_race_fixture.csv",
    :writing => "./test/fixtures/writing_by_race_fixture.csv"},
	 :economic_profile => {
    :median_household_income => "./data/Median household income.csv",
    :children_in_poverty => "./data/School-aged children in poverty.csv",
    :free_or_reduced_price_lunch => "./data/Students qualifying for free or reduced price lunch.csv",
    :title_i => "./data/Title I students.csv" }})
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
			assert_equal EnrollmentRepository, dr4.enrollment.class
			refute dr3.enrollment.contents.empty?
		end

		def test_on_loading_data_the_dr_loads_econ_repo
			assert_instance_of EconomicProfileRepository, dr4.econs
			refute dr4.econs.contents.empty?
		end

	end

