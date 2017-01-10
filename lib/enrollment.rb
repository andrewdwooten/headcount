require 'pry'
class Enrollment
	attr_reader :name_stats

	def initialize(name_stats)
		@name_stats = name_stats
	end

	def kindergarten_participation_by_year
		name_stats[name_stats.keys[1]].each do |year,stat|
			 name_stats[year] = stat.to_s[0..4].to_f end
	end

	def kindergarten_participation_in_year(year)
		name_stats[name_stats.keys[1]][year].to_s[0..4].to_f
	end

	def name
		name_stats.values[0]
	end

	def graduation_rate_by_year
		name_stats[:high_school_graduation]
	end

	def graduation_rate_in_year(year)
		rate = name_stats[:high_school_graduation][year]
		if rate == nil 
			 nil
		else
			rate
		end
	end


end
