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
    			:kindergarten => "./test/fixtures/kindergarteners_fixture.csv",
    				:high_school_graduation => "./test/fixtures/high school gradrates fixture.csv"
  					}}
    dr.load_data(data)  
  end

  def test_build_district_method_returns_array_of_hashes
    assert_equal Array, build_districts(data).class
    assert_equal Hash, build_districts(data)[0].class
    assert_equal 15, build_districts(data).count
  end

  def test_build_enrollments_method_returns_array_of_future_enrollments
    test = build_enrollments(data)
    assert_equal Array, test.class
    assert_equal Hash, test[0].class
    assert_equal [:name, :kindergarten, :high_school_graduation], test[0].keys
  end

  def test_link_to_enroll_links_to_correct_enrollment
    test = link_to_enroll(dr, "academy 20")
    assert_equal Enrollment, test.class
    assert_equal "ACADEMY 20", test.name_stats[:name]
  end

  def test_get_k_returns_hash_of_kindergarten_data_of_enrollment
    enr = link_to_enroll(dr, "academy 20")
    test = get_k(enr)
    assert_equal Hash, test.class
    assert_equal ["2007", "2006"], test.keys
  end

  def test_get_h_returns_hash_of_high_school_grad_rates
    enr = link_to_enroll(dr, "academy 20")
    test = get_h(enr)
    assert_equal Hash, test.class
    assert_equal ({"2010" => 0.895, "2011" => 0.895}), test
  end
end
