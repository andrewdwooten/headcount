class District
	attr_reader :name, :dr

	def initialize(name, dr)
		@name = name[:name]
		@dr = dr
	end

	def enrollment
		(dr.enrollment.contents.select do |enrollment|
		enrollment if enrollment.name_stats[:name] == name end)[0]
	end

end