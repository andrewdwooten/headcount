require_relative 'test_helper.rb'
require '/fixtures/kindergarteners_fixture.csv'

class DistrictRepoTest < MiniTest::Test
	attr_reader :dr

	def setup
		@dr = DistrictRepository.new
			dr.load_data({
  			:enrollment => {
    			:kindergarten => "/fixtures/kindergarteners_fixture.csv"
				}})
	end

		def test_it_is_a_district_repo
			assert_equal DistrictRepository, dr.class
		end

		def test_district_repo_will_accept_data
			dr_contents = dr.contents
			assert_equal Array, dr_contents
			assert_equal District, dr_contents[0].class
		end

		def test_district_repo_can_find_district_by_name
			assert_equal District, dr.find_by_name("Academy").class #need to modify test to assess district attribute
		end

		def test_district_repo_returns_empty_array_if_no_partial_match
			assert_equal [], dr.find_all_matching('zzz')
		end

		def test_district_repo_returns_array_of_districts_if_partial_matches
			search_results = dr.find_all_matching('A')
			assert_equal Array, search_results.class
			assert_equal District, search_results[0].class
		end
	end


			