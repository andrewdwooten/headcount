require './lib/district.rb'
require 'csv'
require 'pry'

class DistrictRepository
	attr_reader :contents

	def initialize
	@contents = []
	end

	def load_data(nest)
		data = CSV.read nest.values[0].values[0], 
			headers: true, header_converters: :symbol
		data.each {|row| contents << {:name => row[0]}}
		contents.uniq!.collect! {|namer| District.new(namer)} 
	end

	def find_by_name(search_name)
		contents.select {|district| district.name == search_name}[0]
	end

	def find_all_matching(fragment)
		contents.select do |district| 
		district.name.include?(fragment.upcase || fragment.downcase) end
	end
end