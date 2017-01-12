require_relative 'headcount_analyst.rb'

class EconomicProfile
  attr_reader :name_stats, :name, :ha

  def initialize(name_stats)
    @name_stats = name_stats
    @name = name_stats[:name]
    @ha = HeadcountAnalyst.new
  end

  def median_household_income_by_year(year)
  values = []
    if check_year?(year) == true
      name_stats[:median_household_income].each do |years, income|
        if year >= years[0] && year <= years[1]
          values << income
        end
      end
    ha.average(values).to_s[0..4].to_i
    else check_year?(year)
    end
  end


  def check_year?(year)
    if  name_stats[:median_household_income].keys.flatten.include?(year)
      true
    else
       'UnknownDataError'
    end
  end

  def median_household_income_average
    ha.average(name_stats[:median_household_income].values)
  end

  def children_in_poverty_in_year(year)
    if name_stats[:children_in_poverty].keys.include?(year)
      name_stats[:children_in_poverty][year]
    else
       "UnknownDataError"
    end
  end

  def free_or_reduced_price_lunch_percentage_in_year(year)
    if name_stats[:free_or_reduced_price_lunch].keys.include?(year)
      name_stats[:free_or_reduced_price_lunch][year][:percentage]
    else
      "UnknownDataError"
    end
  end

  def title_i_in_year(year)
    if name_stats[:title_i].keys.include?(year)
      name_stats[:title_i][year]
    else
      "UnknownDataError"
    end
  end


end
