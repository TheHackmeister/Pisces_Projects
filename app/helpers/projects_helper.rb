module ProjectsHelper
  def set_sort_order(sort, default) 
    if sort.blank?
      sort = default.to_s
      puts sort + "OK"
    end
    puts "Test" + sort
    string_array = sort.split("!")
    string_array.each do |s|
      direction = s.split("_")[-1]
      s = s.remove("_" + direction)
      puts s + direction
      yield s, direction 
    end
  end
end
