require_relative 'district.rb'
require_relative 'enrollment_repository.rb'
require_relative 'parser.rb'
require_relative 'statewidetest_repository.rb'
require 'pry'

class DistrictRepository
include Parser
	attr_reader :contents
	attr_accessor :enrollment, :states

	def initialize
	@contents = []
	@enrollment = EnrollmentRepository.new
	@states = StatewideTestRepository.new
	end

	def load_data(load)
		build_districts(load).each do |base|
      contents << District.new(base, self) end
		enrollment.load_data(load)
		if load.has_key?(:statewide_testing)
			nest = {:statewide_testing=>{}}
			nest[:statewide_testing].merge!(load[:statewide_testing])
			states.load_data(nest)
		else
		end
	end

	def find_by_name(search_name)
		contents.select {|district|
		district.name.downcase == search_name.downcase}[0]
	end

	def find_all_matching(fragment)
		contents.select do |district|
		district.name.downcase.include?(fragment.downcase) end
	end
end