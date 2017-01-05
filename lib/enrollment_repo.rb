require './lib/enrollment.rb'
require 'csv'
require 'pry'

class EnrollmentRepository
	attr_reader :contents

	def initialize
	@contents = []
	end

	def load_data(nest)
		data = CSV.read nest.values[0].values[0], 
			headers: true, header_converters: :symbol
		data.each {|row| unless contents.includes?({:name => row[0]})
			contents << {:name => row[0], :participation => {row[1] => row[3]}}}}}
		
			binding.pry
		contents.uniq!.collect! {|data| Enrollment.new(data)} 
	end

end

# 	def find_by_name(search_name)
# 		contents.select {|district| district.name == search_name}[0]
# 	end

# 	def find_all_matching(fragment)
# 		contents.select do |district| 
# 		district.name.include?(fragment.upcase || fragment.downcase) end
# 	end
# end