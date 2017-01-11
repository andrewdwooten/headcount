class StatewideTest
  attr_reader :name_stats, :name

  def initialize(name_stats)
    @name_stats = name_stats
    @name = name_stats[:name]
  end

  def proficient_by_grade(grade)
  end

end