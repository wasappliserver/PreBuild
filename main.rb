#!/usr/bin/env ruby
require_relative "pre_build.rb"
require 'sqlite3'
require 'rubygems'
require 'fileutils'
require 'optparse'

#get the parameter which is the name of the app
options = {}
OptionParser.new do |opts|
  opts.on("-n", "--name [NAME]", "The name of the app") do |n|
    options[:name] = n
  end
end.parse!

init


#gets all the values from the DB for numbers colors and strings, stores them in array for each
db = SQLite3::Database.new("/Users/wasappliserver/RubymineProjects/ConstantPicker/db/development.sqlite3")
id = db.execute("Select id from apps where name = ?", options[:name])
@rows_number = db.execute("SELECT title, value FROM numbers WHERE app_id = ?", id)
@rows_string = db.execute("SELECT title, value FROM at_strings  WHERE app_id = ?", id)
@rows_color = db.execute("SELECT title, value_coul, coul_type FROM couleurs  WHERE app_id = ?", id)

#log display

#display_rows @rows_number
#display_rows @rows_string
#display_rows @rows_color

path="/Users/wasappliserver/Downloads/Constants.h"

@marker=0
#If the file exist
if (File.exist?(path))
#open it
  File.open(path, 'r+') do |file|
#read lines, fill the tabs
    @lines_init = file.readlines
    @lines_final = @lines_init.dup


    @rows_number.each do |row|
      puts "ROW ==>" + row.to_s


      if (compareLinesN(row)== false)
        #ADD THE ROWWWW
        puts
        puts "ADD NEW ROW NUMBER"
        addRowNumber row
      end
    end

    @rows_color.each do |row|
      if (compareLinesC(row)== false)
        #ADD THE ROWWWW
        puts
        puts "ADD NEW ROW COLOR"
        addRowColor row
      end
    end

    @rows_string.each do |row|
      if (compareLinesS(row)== false)
        #ADD THE ROWWWW
        puts
        puts "ADD NEW ROW String"
        addRowString row
      end
    end

  end
end
File.open(path, 'w') do |file|
  @lines_final.each do |line|
    file << line.to_s
  end
end

