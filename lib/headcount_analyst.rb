require 'pry'
require_relative 'district_repo'

class HeadcountAnalyst
  attr_reader :dr

  def initialize(dr = DistrictRepository.new)
    @dr = dr
  end

  def kindergarten_participation_rate_variation(district1, district2)

  end

  def average(digits)
    truncate((digits.reduce(0) do |k, v|
      k += v
    end) / digits.count)
  end


  def truncate(input)
    input.to_f.round(3)
  end
end
