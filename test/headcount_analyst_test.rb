require './lib/district_repository.rb'
require './lib/headcount_analyst.rb'
require_relative 'test_helper'

class HeadcountAnalystTest < Minitest::Test
  attr_reader :dr, :ha

  def setup
    @dr = DistrictRepository.new
    @dr.load_data({
      :enrollment => {
        :kindergarten => './test/fixtures/kindergarteners_fixture.csv',
        :high_school_graduation => './test/fixtures/high school gradrates fixture.csv'
      }
    })
    @ha = HeadcountAnalyst.new(dr)
  end

  def test_it_exists
    assert_instance_of HeadcountAnalyst, ha
  end

  def test_it_can_return_an_average
    numbers = {"one" => 0.123, "two" => 0.456, "three" => 0.789 }
    assert_equal 0.455, ha.average(numbers.values)
  end

  def test_it_can_access_district_repo_and_enrollment
    district = dr.find_by_name("ACADEMY 20")
    assert_equal 0.391, district.enrollment.kindergarten_participation_in_year(2007)
  end

  def test_it_can_compare_district_to_state
    assert_equal 0.685, ha.kindergarten_participation_rate_variation('ACADEMY 20', :against => 'COLORADO')
  end

  def test_it_can_compare_two_districts
    assert_equal 0.0, ha.kindergarten_participation_rate_variation('ACADEMY 20', :against => 'AKRON R-1')
  end


  def test_it_can_compare_trends_by_year
    test = ha.kindergarten_participation_rate_variation_trend('Academy 20', :against => 'Adams County 14')
    assert_equal Hash, test.class
    assert_equal ({2007=>0.349, 2006=>0.323}), test
  end

  def test_kindergarten_vs_high_school_outputs_a_float
    test = ha.kindergarten_participation_against_high_school_graduation('Academy 20')
    assert_equal Float, test.class
    assert_equal 0.575, test
  end

  def test_determine_correlation_returns_boolean_appropriately
    assert ha.determine_correlation?(1)
    refute ha.determine_correlation?(1.5)
    assert ha.determine_correlation?(0.7)
    refute ha.determine_correlation?(0.6)
  end

  def test_k_versus_highschool_multiple_returns_array_of_booleans
    districts = ['academy 20', 'littleton 6', 'Akron r-1']
    test_array = ha.k_versus_highschool_multiple(districts)
    refute test_array[0]
    assert test_array[1]
    refute test_array[2]
    assert_equal 3, test_array.count
  end

  def test_kindergarten_correlations_function_appropriately_for_all_cases
    districts = ['academy 20', 'littleton 6', 'Akron r-1']
    test1 = ha.kindergarten_participation_correlates_with_high_school_graduation(for: 'Academy 20')
    test2 = ha.kindergarten_participation_correlates_with_high_school_graduation(:for=>'STATEWIDE')
    test3 = ha.kindergarten_participation_correlates_with_high_school_graduation(:across=>districts)
    refute test1
    refute test2
    refute test3
  end
end

