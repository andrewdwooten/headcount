require_relative 'enrollment.rb'
require_relative 'parser.rb'

class EnrollmentRepository
  include Parser
	attr_reader :contents

	def initialize
	@contents = []
	end

	def load_data(nest)
    build_enrollments(nest).each do |enroller|
      contents << Enrollment.new(enroller)
    end
	end

	def find_by_name(search)
		contents.detect {|enroll|
			 enroll.name.downcase == search.downcase}
	end
end