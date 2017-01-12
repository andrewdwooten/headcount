require_relative 'parser'

class EconomicProfileRepository
  include Parser

  attr_reader :contents

  def initialize
    @contents = []
  end

  def load_data(load)
    build_econ(load)
    
  end

end
