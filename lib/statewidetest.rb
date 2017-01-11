class StatewideTest
  attr_reader :name_stats, :name, :races, :subjects

  def initialize(name_stats)
    @name_stats = name_stats
    @name = name_stats[:name]
    @races = [:asian, :black, :pacific_islander, :hispanic, :native_american, :two_or_more, :white]
    @subjects = [:math, :reading, :writing]
  end

  def proficient_by_grade(grade)
    case
      when grade == 3
        name_stats[:third_grade]
      when grade == 8
        name_stats[:eighth_grade]
    end
  end

  def proficient_by_race_or_ethnicity(race)
    if check_race?(race)
      name_stats[race]
    end
  end

  def proficient_for_subject_by_grade_in_year(subject, grade, year)
  end

  def check_race?(race)
    if races.include?(race) != true
      return 'raise UnknownRaceError'
    else
      true
    end
  end

  def check_subject(subject)

  end
end