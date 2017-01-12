require_relative 'test_helper.rb'
require './lib/district.rb'
require './lib/statewide_test.rb'
require './lib/district_repository.rb'

class DistrictTest < MiniTest::Test
attr_reader :dr

def setup
@dr = DistrictRepository.new
			dr.load_data({
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

  def test_it_is_a_district
    d = District.new(name: "ACADEMY 20")
    assert_equal District, d.class
  end

  def test_districts_have_names
    d = District.new(name: "ACADEMY 20")
    assert_equal "ACADEMY 20", d.name
  end

  def test_independent_districts_do_not_have_a_DR
    d = District.new(name: "Academy 20")
    assert_equal nil, d.dr
  end

  def test_district_repo_districts_have_relationship_with_enrollment
		district = dr.find_by_name("Academy 20")
		assert_equal 0.391, district.enrollment.kindergarten_participation_in_year(2007)
	end
  
  def test_district_repo_districts_have_relationship_with_statewide_test
		district = dr.find_by_name('colorado')
		assert_equal StatewideTest, district.statewide_test.class
		assert_equal 0.3926, district.statewide_test.proficient_for_subject_by_race_in_year(:math,:hispanic, 2011)
		assert_equal 'Colorado', district.name
	end

  def test_district_repo_districts_have_relationship_with_economic
    district = dr.find_by_name('academy 20')
    assert_instance_of EconomicProfile, district.economic_profile
  end
			
end
