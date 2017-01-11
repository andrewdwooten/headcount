require_relative 'statewidetest.rb'
require_relative 'parser.rb'

class StatewideTestRepository
  include Parser
	attr_reader :contents

	def initialize
	@contents = []
	end

	def load_data(nest)
    build_grades(nest).each do |test|
      contents << StatewideTest.new(test)
    end
	end

	def find_by_name(search)
		contents.detect {|test|
			 test.name.downcase == search.downcase}
	end
end