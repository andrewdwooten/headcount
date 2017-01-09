require 'pry'
require_relative 'district_repo'

class HeadcountAnalyst
  attr_reader :dr

  def initialize(dr = DistrictRepository.new)
    @dr = dr
  end

  def kindergarten_participation_rate_variation(district1, district2)
    dist1 = average(@dr.find_by_name(district1).enrollment.kindergarten_participation_by_year.values)
    dist2 = average(@dr.find_by_name(district2[:against]).enrollment.kindergarten_participation_by_year.values)
    dist1 / dist2
  end

  def average(digits)
    truncate((digits.reduce(0) do |k, v|
      k += v
    end) / digits.count)
  end


  def truncate(input)
    input.to_f.round(3)
  end

  def participation_average

  end
end



