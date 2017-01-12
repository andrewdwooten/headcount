class District
	attr_reader :name, :dr

	def initialize(name, dr=nil)
		@name = name[:name]
		@dr = dr
	end

	def enrollment
		(dr.enrollment.contents.select do |enrollment|
			enrollment if enrollment.name_stats[:name] == name end)[0]
	end

	def statewide_test
		(dr.states.contents.select do |state|
			state if state.name == name end)[0]
	end

	def economic_profile
		(dr.econs.contents.select do |econ|
			econ if econ.name == name end)[0]
	end

end