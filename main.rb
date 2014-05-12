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
@rows_number = db.execute("SELECT title, value FROM numbers n JOIN apps a where a.name = '#{options[:name]}'")
@rows_string = db.execute("SELECT title, value FROM at_strings n JOIN apps a where a.name = '#{options[:name]}'")
@rows_color = db.execute("SELECT title, value_coul FROM couleurs n JOIN apps a where a.name = '#{options[:name]}'")

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
    @lines = file.readlines

    #dabord les rows numbers
    @rows_number.each do |row|
      if(compareLinesN row == false)
        #ADD THE ROWWWW
        puts "ADD NEW ROW"
      end
    end
  end
end
