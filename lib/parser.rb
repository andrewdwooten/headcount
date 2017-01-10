require 'csv'
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
  
end

