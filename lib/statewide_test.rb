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
      when grade != 3 && grade != 8
       return 'raise UnknownDataError'
    end
  end

  def proficient_by_race_or_ethnicity(race)
    if check_race?(race)
      name_stats[race]
    else
      check_race?(race)
    end
  end

  def proficient_for_subject_by_grade_in_year(subject, grade, year)
    if check_grade?(grade) == true && check_subject?(subject) == true
      if proficient_by_grade(grade)[year] != nil
        proficient_by_grade(grade)[year][subject]
      else
        return 'Unknown DataError'
      end
    else
      return 'Unknown DataError'
    end
  end

  def check_race?(race)
    if races.include?(race) != true
       return 'raise UnknownRaceError'
    else
      true
    end
  end

  def check_subject?(subject)
    subjects.include?(subject)
  end

  def check_grade?(grade)
    grade == 3 || grade ==8
  end

  def proficient_for_subject_by_race_in_year(subject,race,year)
    case
      when check_race?(race) == true && check_subject?(subject) == true
        if name_stats[race].has_key?(year)
          name_stats[race][year][subject]
        else
          return 'UnknownDataError'
        end
      when check_race?(race) != true
        check_race?(race)
      when check_subject?(subject) != true
        check_subject?(subject)
    end
  end

end
