require './lib/enrollment.rb'
require 'csv'
require 'pry'

class EnrollmentRepository
	attr_reader :contents

	def initialize
	@contents = []
	end

	def load_data(nest)
		nest.values[0].each do |symbol, file|
      data = CSV.read file, headers: true, header_converters: :symbol
      data.each {|row| contents << {:name=>row[0]}; contents.uniq!}
      contents.each {|future_enrollment| future_enrollment[symbol] = {}}
      data.each {|row| contents.each do |future_enrollment| if future_enrollment[:name] == row[0] 
        future_enrollment[symbol].merge!({row[1]=>row[3]})
          end
        end}
    end
    contents.select! {|enroller| enroller.keys.count == (nest.values[0].keys.count + 1)}
    contents.map! {|enroller| Enrollment.new(enroller)} 
	end

	def find_by_name(search)
		contents.detect {|enroll|
			 enroll.name.downcase == search.downcase}
	end
end
