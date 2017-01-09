require_relative 'test_helper.rb'
require './lib/parser.rb'
require './lib/district_repo.rb'

class ParserTest < MiniTest::Test
  include Parser
  attr_reader :dr, :data
  def setup
    @dr = DistrictRepository.new
			@data = {
  			:enrollment => {
    			:kindergarten => "./test/fixtures/kindergarteners_fixture.csv"
				}}
  end

  def test_build_base_method_returns_array_of_hashes
    assert_equal Array, build_base(data).class
    assert_equal Hash, build_base(data)[0].class
    assert_equal 15, build_base(data).count
  end

  def test_link_to_enroll_links_to_correct_enrollment
    dr.load_data(data)
    test = link_to_enroll(dr, "academy 20")
    assert_equal Enrollment, test.class
    assert_equal "ACADEMY 20", test.name_stats[:name]
  end

  def test_get_k_returns_hash_of_kindergarten_data_of_enrollment
    dr.load_data(data)
    enr = link_to_enroll(dr, "academy 20")
    test = get_k(enr)
    assert_equal Hash, test.class
    assert_equal ["2007", "2006"], test.keys
  end
end
