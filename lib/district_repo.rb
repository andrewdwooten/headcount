require './lib/district.rb'
require './lib/enrollment_repo.rb'
require 'csv'
require 'pry'

class DistrictRepository
	attr_reader :contents 
	attr_accessor :enrollment

	def initialize
	@contents = []
	@enrollment = EnrollmentRepository.new
	end

	def load_data(load)
		data = CSV.read load.values[0].values[0], 
			headers: true, header_converters: :symbol
		data.each {|row| contents << {:name => row[0]}}
		contents.uniq!.collect! {|namer| District.new(namer)}
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