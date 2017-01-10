require_relative 'district_repository.rb'
require_relative 'parser.rb'
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
    k = kindergarten_participation_rate_variation(district, :against => "Colorado")
    h = graduation_variation(district)
    truncate(k/h)
  end

  def kindergarten_participation_correlates_with_high_school_graduation(district)
    case
    when district[:for] == 'STATEWIDE'
        districts = []
        dr.contents.each {|district| districts << district.name}
        kindergarten_participation_correlates_with_high_school_graduation(:across=>districts)
    when district[:for] != 'STATEWIDE' && district[:for].class == String
        cor = kindergarten_participation_against_high_school_graduation(district[:for])
          determine_correlation?(cor)
    when district[:across].class == Array
       a = k_versus_highschool_multiple(district[:across]).delete_if do |boolean|
          boolean == true end
       a.empty?
    end
  end
        
    def determine_correlation?(cor)
      cor > 0.6 && cor < 1.5
    end

    def k_versus_highschool_multiple(districts)
      districts.map! do |district|
        v = kindergarten_participation_against_high_school_graduation(district)
        determine_correlation?(v)
      end
    end

  end





