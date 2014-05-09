#!/usr/bin/env ruby
require 'sqlite3'
require 'rubygems'
require 'fileutils'
require 'optparse'

#displaying rows to debug/log
def display_rows rows
  rows.each do |row|
    puts row.to_s
  end
  puts ''
end


#get the parameter which is the name of the app
options = {}
OptionParser.new do |opts|
  opts.on("-n", "--name [NAME]", "The name of the app") do |n|
    options[:name] = n
  end
end.parse!

#gets all the values from the DB for numbers colors and strings, stores them in array for each
db = SQLite3::Database.new("/Users/wasappliserver/RubymineProjects/ConstantPicker/db/development.sqlite3")
rows_number = db.execute("SELECT title, value FROM numbers n JOIN apps a where a.name = '#{options[:name]}'")
rows_string = db.execute("SELECT title, value FROM at_strings n JOIN apps a where a.name = '#{options[:name]}'")
rows_color = db.execute("SELECT title, value_coul FROM couleurs n JOIN apps a where a.name = '#{options[:name]}'")

#log display
display_rows rows_number
display_rows rows_string
display_rows rows_color

path="/Users/wasappliserver/.jenkins/jobs/#{options[:name]}/workspace/#{options[:name]}/Constants.h"
text = Array.new
patt_strings="/(\S*)\s(\S*)\s*(@\"\S*\")/"
patt_colors="/\S+\s(\S*)\s\[(\S*)\s(.*):([\w]*)\]/"
patt_numbers= "/(\S*)\s(\S*)\s(\d+)/"

#If the file exist
if (File.exist?(path))
#open it
  File.open(path) do |file|
#read lines
    text = file.readlines
#loop with lines
    for i in 0..text.count-1

      #if pattern =~ '#define'
      if (text[i][/#define/])

        #function line =~ pattern color/string/number, puts 'color' or 'number' or 'string' int @line_type, return true or false
        if (isLine(text[i]))

          #if line match a row (function return boolean)
          if ()
            #modify the value
            modifiyLine(text[i])

            #else dont touch
          else

          end
        end #endif

      end #endfor

    end #endif

  end #endif

end

def isLine str

end

def modifyLine str
  
end
