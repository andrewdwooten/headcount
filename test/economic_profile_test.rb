require_relative 'test_helper.rb'
require './lib/economic_profile_repository.rb'
require './lib/economic_profile.rb'

class EconomicProfileTest < Minitest::Test
  attr_reader :epr, :ep, :econ

  def setup
    @epr = EconomicProfileRepository.new
    epr.load_data({
  :economic_profile => {
    :median_household_income => "./data/Median household income.csv",
    :children_in_poverty => "./data/School-aged children in poverty.csv",
    :free_or_reduced_price_lunch => "./data/Students qualifying for free or reduced price lunch.csv",
    :title_i => "./data/Title I students.csv"
  }
})
    @ep = EconomicProfile.new({:name=>'frank'})
    @econ = epr.find_by_name('academy 20')

  end

    def test_it_is_an_economic_profile
      assert_instance_of EconomicProfile, ep
    end

    def test_median_household_income_by_year_output_is_valid_and_errors
      assert_equal 87056, econ.median_household_income_by_year(2008)
      assert_equal 'UnknownDataError', econ.median_household_income_by_year(1885)
    end

    def test_median_household_income_average
      assert_equal 87635, econ.median_household_income_average
    end

    def test_children_in_poverty_in_year_is_valid_and_errors
      assert_equal 0.032, econ.children_in_poverty_in_year(1995)
      assert_equal 'UnknownDataError', econ.children_in_poverty_in_year(2037)
    end

    def test_free_and_reduced_lunches_returns_value_and_errors
      assert_equal 0.25486, econ.free_or_reduced_price_lunch_percentage_in_year(2014)
      assert_equal 'UnknownDataError', econ.free_or_reduced_price_lunch_percentage_in_year(2089)
    end

    def test_title_i_in_year_outputs_value_and_errors
      assert_equal 0.01072, econ.title_i_in_year(2012)
      assert_equal "UnknownDataError", econ.title_i_in_year(49999)
    end
  end