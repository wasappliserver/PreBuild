def init
  @rows_color= Array.new
  @rows_string = Array.new
  @rows_number = Array.new

end

#################################################################

########## N U M B E R S ##############
def compareLinesN row

  for i in 0..@lines_init.count-1
    #puts "LIGNE REGARDEE =>" + @lines_init[i].to_s
    if (@lines_init[i]=~ /(#\S*)\s(\S*)\s(\d+)/m)
      if (compareOneLineN(i, row))
        return true
      end
    end
  end
  return false
end


def compareOneLineN i, row
  data = @lines_init[i].scan(/(#\S*)\s(\S*)\s(\d+)/)
  puts "NUMBER data|||row ===>" + data[0][1].to_s + "|||" + row[0].to_s

  if (data[0][1]==row[0])
    puts "MATCH " #NUMBER data|||row ===>" + data[0][1].to_s + "|||" +row[0].to_s
    puts "LINE BEFORE" + @lines_final[i].to_s
    @lines_final[i] = "#define #{row[0]} #{row[1]}\n"
    puts "LINE AFTER" + @lines_final[i].to_s
    puts
    return true
  end
  return false
end

##############################################################################

########## S T R I N G S ##############
def compareLinesS row

  for i in 0..@lines_init.count-1
    puts "LIGNE REGARDEE =>" + @lines_init[i].to_s
    if (@lines_init[i]=~ /(\S*)\s(\S*)\s*(@"\S*")/m)
      if (compareOneLineS(i, row))
        return true
      end
    end
  end
  return false
end

def compareOneLineS i, row
  data = @lines_init[i].scan(/(\S*)\s(\S*)\s*(@"\S*")/)
  puts "String data|||row ===>" + data[0][1].to_s + "|||" + row[0].to_s

  if (data[0][1]==row[0])
    puts "MATCH " #NUMBER data|||row ===>" + data[0][1].to_s + "|||" +row[0].to_s
    puts "LINE BEFORE" + @lines_final[i].to_s
    @lines_final[i] = "#define #{row[0]} @\"#{row[1]}\"\n"
    puts "LINE AFTER" + @lines_final[i].to_s
    puts
    return true
  end
  return false
end

##############################################################################

########## C O L O R S ##############
def compareLinesC row

  for i in 0..@lines_init.count-1
    #puts "LIGNE REGARDEE =>" + @lines_init[i].to_s
    if (@lines_init[i]=~ /\S+\s(\S*)\s\[(\S*)\s(.*):([\w]*)\]/m)
      if (compareOneLineC(i, row))
        return true
      end
    end
  end
  return false
end

def compareOneLineC i, row
  data = @lines_init[i].scan(/\S+\s(\S*)\s\[(\S*)\s(.*):([\w]*)\]/)
  puts "Color data|||row ===>" + data[0][0].to_s + "|||" + row[0].to_s

  if (data[0][0]==row[0])
    puts "MATCH " #NUMBER data|||row ===>" + data[0][1].to_s + "|||" +row[0].to_s
    puts "LINE BEFORE" + @lines_final[i].to_s
    @lines_final[i] = "#define #{row[0]} [#{row[2]} colorWithHexa:#{row[1]}]\n"
    puts "LINE AFTER" + @lines_final[i].to_s
    puts
    return true
  end
  return false
end

####################################

########## A D D  R O W  N U M B E R ##############
def addRowNumber row

  #on doit atteindre le #endif et ecrire avant
  for i in 0..@lines_init.count-1
    if (@lines_final[i] =~ /#endif/)
      @lines_final.insert(i-1, "#define #{row[0]} #{row[1]}\n")
      puts "line i-1 after" + @lines_final[i-1].to_s
    end
  end
end

######################################

########## A D D  R O W  C O L O R ##############
def addRowColor row

  #on doit atteindre le #endif et ecrire avant
  for i in 0..@lines_final.count-1
    if (@lines_final[i] =~ /#endif/)
      @lines_final.insert(i-1, "#define #{row[0]} [#{row[2]} colorWithHexa:#{row[1]}]\n")
      puts "line i-1 after" + @lines_final[i-1].to_s
    end
  end
end

######################################

########## A D D  R O W  S T R I N G ##############
def addRowString row

  #on doit atteindre le #endif et ecrire avant
  for i in 0..@lines_final.count-1
    if (@lines_final[i] =~ /#endif/)
      @lines_final.insert(i-1, "#define #{row[0]} @\"#{row[1]}\"\n")
      puts "line i-1 after" + @lines_final[i-1].to_s
    end
  end
end
######################################