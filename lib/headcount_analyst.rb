require_relative 'district_repo'
require_relative 'parser'
require 'pry'

class HeadcountAnalyst
include Parser
  attr_reader :dr

  def initialize(dr = DistrictRepository.new)
    @dr = dr
  end

  def kindergarten_participation_rate_variation(district1, district2)
    truncate(average(get_k_values(link_to_enroll(dr, district1))) /
     average(get_k_values(link_to_enroll(dr, district2[:against]))))
  end

  def average(digits)
    truncate((digits.reduce(0) do |start, number|
      start += number
    end) / digits.count)
  end

  def truncate(input)
    input.to_s[0..4].to_f
  end

  def kindergarten_participation_rate_variation_trend(district1, district2)
    k1 = get_k(link_to_enroll(dr, district1))
    k2 = get_k(link_to_enroll(dr, district2[:against]))
    k1.each {|year, percent| k1[year] = truncate(average([k2[year],percent]))}
  end

  def graduation_variation(district1, district2 = "Colorado")
    truncate(average(get_h_values(link_to_enroll(dr,district1))) /
      average(get_h_values(link_to_enroll(dr, district2))))
  end

  def kindergarten_participation_against_high_school_graduation(district)
    k = kinder
end



