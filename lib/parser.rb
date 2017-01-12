require 'csv'
require 'pry'
module Parser

def build_districts(nest)
  file = nest[:enrollment][:kindergarten]
  contents = []
  data = CSV.read file, headers: true, header_converters: :symbol
  data.each {|row| contents << {:name => row[0]}; contents.uniq!}
  contents
end

def build_enrollments(nest)
  contents = []
  nest.values[0].each do |symbol, file|
      data = CSV.read file, headers: true, header_converters: :symbol
      data.each {|row| contents << {:name=>row[0]}; contents.uniq!}
      contents.each {|future_enrollment| future_enrollment[symbol] = {}}
      data.each {|row| contents.each do |future_enrollment| if future_enrollment[:name] == row[0]
        future_enrollment[symbol].merge!({row[1].to_i=>row[3].to_f})
          end
        end}
    end
    cleanup(contents, nest)
end

def build_grades(nest)
  sub_nest = {}
  sub_nest.merge!(:third_grade=>nest[:statewide_testing][:third_grade])
  sub_nest.merge!(:eighth_grade=>nest[:statewide_testing][:eighth_grade])
  contents = []
  sub_nest.each do |symbol, file|
    data = CSV.read file, headers: true, header_converters: :symbol
    data.each {|row| contents << {:name=>row[0]}; contents.uniq!}
    contents.each {|future_state| future_state[symbol] = {}}
    data.each do |row|
      contents.each {|future_state| future_state[symbol][row[2].to_i] = {}; contents.uniq!}
    end
    data.each do |row|
      contents.each do |future_state| if future_state[:name] == row[0]
        future_state[symbol][row[2].to_i].merge!(row[1].downcase.to_sym=>row[4].to_f)
        end
      end
    end
  end
    build_race_stats(test_cleanup(contents,sub_nest), nest)
end

def build_race_stats(contents, nest)
  sub_nest = {}
  sub_nest.merge!(:math=>nest[:statewide_testing][:math])
  sub_nest.merge!(:reading=>nest[:statewide_testing][:reading])
  sub_nest.merge!(:writing=>nest[:statewide_testing][:writing])
  sub_nest.each do |symbol, file|
    data = CSV.read file, headers: true, header_converters: :symbol
    data.each do |row|
      contents.each do |future_state|
        if future_state[:name] == row[0]
          future_state[row[1].downcase.gsub(' ', '_').to_sym] = {}
        end
      end
    end
    data.each do |row|
      contents.each do |future_state|
        if future_state[:name] == row[0]
          future_state[row[1].downcase.gsub(' ', '_').to_sym][row[2].to_i] = {}
        end
      end
    end
  end
  sub_nest.each do |symbol, file|
    data = CSV.read file, headers: true, header_converters: :symbol
    data.each do |row|
      contents.each do |future_state|
        if future_state[:name] == row[0]
          future_state[row[1].downcase.gsub(' ', '_').to_sym][row[2].to_i].merge!(symbol.to_sym=>row[4].to_f)
        end
      end
    end
  end
  fix_keys(contents)
end

  def test_cleanup(load_base, base)
    load_base.map! {|test| test if test.keys.count == base.keys.count + 1}.compact!
  end


  def fix_keys(box_o_future_states)
    box_o_future_states.each do |state|
      state[:pacific_islander] = state.delete(:"hawaiian/pacific_islander")
    end
  end

  def cleanup(load_base, base)
    load_base.map! {|enroller| enroller if enroller.keys.count == base.values[0].keys.count + 1}.compact
  end

  def link_to_enroll(repo, dist)
    repo.find_by_name(dist).enrollment
  end

  def get_k_values(enr)
    enr.kindergarten_participation_by_year.values
  end

  def get_k(enr)
    enr.name_stats[:kindergarten]
  end

  def get_h(enr)
    enr.name_stats[:high_school_graduation]
  end

  def get_h_values(enr)
    enr.graduation_rate_by_year.values
  end

  def build_econ(nest)
    contents = []
    subnest = {}
  subnest.merge!(:median_household_income=>nest[:economic_profile][:median_household_income])
    subnest.each do |symbol, file|
      data = CSV.read file, headers: true, header_converters: :symbol
      data.each { |row| contents << {:name => row[0],symbol.to_sym => {}}; contents.uniq! }
      data.each do |row|
        contents.each do |future_econ| if future_econ[:name] == row[0]
          future_econ[symbol.to_sym].merge!(row[1].split('-') => row[3].to_i)
        end
      end
    end
    binding.pry
   contents
  end

  def cleanup_strings(contents)
    binding.pry
    contents[:median_household_income].each_key do |key|
      key.each {|element| element.to_i}
    end
    end
  end
end

