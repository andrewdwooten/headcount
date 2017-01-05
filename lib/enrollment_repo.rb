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
		data.each {|row| contents << {:name => row[0], :kindergarten_participation => {}}; contents.uniq!}
		data.each do |row| if contents[0].has_value?(row[0]) then 
			contents[0].values[1].merge!({row[1] => row[3]})	end end
		contents.collect! {|data| Enrollment.new(data)} 
	end

	def find_by_name(search)
		contents.detect {|enroll|
			 enroll.name.downcase == search.downcase}
	end
end
