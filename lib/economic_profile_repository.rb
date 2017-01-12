require_relative 'economic_profile.rb'
require_relative 'parser.rb'

class EconomicProfileRepository
  include Parser
  attr_reader :contents

  def initialize
    @contents = []
  end

  def load_data(load)
    build_econ(load).each do |build|
      contents << EconomicProfile.new(build)
    end
  end

  def find_by_name(search)
	  contents.detect {|econ|
		  econ.name.downcase == search.downcase}
	end

end
