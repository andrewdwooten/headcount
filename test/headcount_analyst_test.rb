require '../lib/district_repo'
require '../lib/headcount_analyst'
require_relative 'test_helper'

class HeadcountAnalystTest < Minitest::Test

  def setup
    @dr = DistrictRepository.new
    @dr.load_data({
      :enrollment => {
        :kindergarten => '../test/fixtures/kindergartners.csv',
        :high_school_graduation => '../test/fixtures/high_school_graduation_rates.csv'
      }
    })
    @ha = HeadcountAnalyst.new(@dr)
  end

  def test_it_exists
    assert_instance_of HeadcountAnalyst, @ha
  end

  def test_it_can_return_an_average
    numbers = {"one" => 0.123, "two" => 0.456, "three" => 0.789 }
    assert_equal 0.456, @ha.average(numbers.values)
  end

  def test_it_can_access_district_repo_and_enrollment
    district = @dr.find_by_name("ACADEMY 20")
    assert_equal 0.391, district.enrollment.kindergarten_participation_in_year("2007")
  end

  def test_it_can_compare_two_districts
    assert_equal 0.685, @ha.kindergarten_participation_rate_variation('ACADEMY 20', :against => 'COLORADO')
  end


end

end

