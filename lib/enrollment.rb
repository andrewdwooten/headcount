require 'pry'
class Enrollment
	attr_reader :name_stats

	def initialize(name_stats)
		@name_stats = name_stats
	end

	def kindergarten_participation_by_year
		name_stats.values[1].each do |year,stat|
			 name_stats[year] = stat.to_s[0..4].to_f end
	end

	def kindergarten_participation_in_year(year)
		name_stats.values[1].values_at(year)
	end

	def name
		name_stats.values[0]
	end
end
