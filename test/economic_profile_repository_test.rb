require_relative 'test_helper.rb'
require './lib/economic_profile_repository'

class EconomicProfileRepositoryTest < Minitest::Test
  attr_reader :epr

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
  end

  def test_it_exists
    assert_instance_of EconomicProfileRepository, epr
  end

  def test_it_can_load_data
    skip
  end

  def test_it_can_find_schools_by_name
    skip
  end

end