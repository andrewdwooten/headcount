require_relative 'test_helper'
require './lib/statewidetest.rb'
require './lib/statewidetest_repository.rb'

class StatewideTestTest < MiniTest::Test
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

	def test_it_is_a_statewide_test
		assert_equal StatewideTest, sr.contents[0].class
	end

	def test_they_have_names_and_know_them
		assert_equal 'Colorado', sr.contents[0].name
		assert_equal 'ACADEMY 20', sr.contents[1].name
	end

	def test_proficient_by_grade_returns_hash_of_proficiencies
		output_a = {2009=>{:math=>0.691, :reading=>0.726, :writing=>0.536},                                                                                            
    2010=>{:math=>0.706, :reading=>0.698, :writing=>0.504},                                                                                            
    2008=>{:reading=>0.703, :writing=>0.501},                                                                                                          
    2011=>{:math=>0.696, :reading=>0.728, :writing=>0.513},                                                                                            
    2012=>{:reading=>0.739, :math=>0.71, :writing=>0.525},                                                                                             
    2013=>{:math=>0.72295, :reading=>0.73256, :writing=>0.50947},                                                                                      
    2014=>{:math=>0.71589, :reading=>0.71581, :writing=>0.51072}}
		output_b = {2008=>{:math=>0.64, :reading=>0.843, :writing=>0.734},                                                                                             
    2009=>{:math=>0.656, :reading=>0.825, :writing=>0.701},                                                                                            
    2010=>{:math=>0.672, :reading=>0.863, :writing=>0.754},                                                                                            
    2011=>{:reading=>0.83221, :math=>0.65339, :writing=>0.74579},                                                                                      
    2012=>{:math=>0.68197, :writing=>0.73839, :reading=>0.83352},                                                                                      
    2013=>{:math=>0.6613, :reading=>0.85286, :writing=>0.75069},                                                                                       
    2014=>{:math=>0.68496, :reading=>0.827, :writing=>0.74789}}
		assert_equal output_a, sr.contents[0].proficient_by_grade(3)
		assert_equal output_b, sr.contents[1].proficient_by_grade(8)
	end


	end