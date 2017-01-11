class StatewideTest
  attr_reader :name_stats, :name

  def initialize(name_stats)
    @name_stats = name_stats
    @name = name_stats[:name]
  end

  def proficient_by_grade(grade)
    case
      when grade == 3
        name_stats[:third_grade]
      when grade == 8
        name_stats[:eighth_grade]
    end
  end

end