require_relative 'district'
require_relative 'enrollment_repo'
require_relative 'parser'
require 'pry'

class DistrictRepository
include Parser
	attr_reader :contents
	attr_accessor :enrollment

	def initialize
	@contents = []
	@enrollment = EnrollmentRepository.new
	end

	def load_data(load)
		build_districts(load).each do |base|
      contents << District.new(base, self) end
		enrollment.load_data(load)
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