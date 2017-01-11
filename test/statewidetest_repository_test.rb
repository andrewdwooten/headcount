require_relative 'test_helper.rb'
require_relative '../lib/statewidetest.rb'
require_relative '../lib/statewidetest_repository.rb'

class StatewideTestRepositoryTest < MiniTest::Test
	attr_reader :sr

	def setup
		@sr = StatewideTestRepository.new
			sr.load_data({
        :statewide_testing => {
        :third_grade => "./test/fixtures/3rdgrdproficient_fixture.csv",
        :eighth_grade => "./test/fixtures/8thgrdproficient_fixture.csv",
        :math => "./test/fixtures/math_by_race_fixture.csv",
        :reading => "./test/fixtures/reading_by_race_fixture.csv",
        :writing => "./test/fixtures/writing_by_race_fixture.csv"}})
	end

  def test_it_is_a_statewide_repository
    assert_equal StatewideTestRepository, sr.class
  end

  def test_sr_instance_contains_array_of_statewide_tests
    assert_equal Array, sr.contents.class
    assert_equal StatewideTest, sr.contents[0].class
  end

  def test_state_repo_can_find_a_state_test_by_name
    assert_equal StatewideTest, sr.find_by_name('academy 20').class
    assert_equal 'ACADEMY 20', sr.find_by_name('academy 20').name
  end
end