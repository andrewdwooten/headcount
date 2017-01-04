require_relative 'test_helper.rb'
require './lib/district.rb'

class DistrictTest < MiniTest::Test

	def test_it_is_a_district
		d = District.new({:name => "ACADEMY 20"})
		assert_equal District, d.class
	end

	def test_districts_have_names
		d = District.new({:name => "ACADEMY 20"})
		assert_equal "ACADEMY 20", d.name
	end
end