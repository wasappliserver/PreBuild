def init
  @rows_color= Array.new
  @rows_string = Array.new
  @rows_number = Array.new

end

def compareLinesN row

  for i in 0..@lines.count-1
    if (@lines[i]=~ /(#\S*)\s(\S*)\s(\d+)/m)
      if (compareLineN(i, row))
        return true
      else
        return false
      end
    end
  end
end

def compareLineN i, row
  data = @lines[i].scan(/(#\S*)\s(\S*)\s(\d+)/)
  if (data[0][1]==row[0])
    puts "MATCH NUMBER data|||row ===>" + data[0][1].to_s + "|||" +row[0].to_s
    puts "ROW" + row.to_s
    @lines[i] = "#define #{row[0]} #{row[1]}"
    puts @lines[i].to_s
    return true
  end
  return false
end

def compareLineS i, row
  data = @lines[i].scan(/(\S*)\s(\S*)\s*(@"\S*")/)

  if (data[0][1]==row[0])
    puts "MATCH ===>" + data[0][1].to_s + "|||" +row[0].to_s
    return true
  end
end

def compareLineC i, row
  data = @lines[i].scan(/\S+\s(\S*)\s\[(\S*)\s(.*):([\w]*)\]/)
  if (data[0][1]==row[0])
    puts "MATCH ===>" + data[0][1].to_s + "|||" +row[0].to_s
    return true
  end
end

