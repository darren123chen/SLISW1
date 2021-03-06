module ActsAsCsv

 def self.included(base)
  base.extend ClassMethods
 end

 module ClassMethods
  def acts_as_csv
   include InstanceMethods
  end
 end

 module InstanceMethods

  def read
   @csv_contents = []
   filename = self.class.to_s.downcase + '.txt'
   file = File.new(filename)
   @headers = file.gets.chomp.split(', ')

   file.each do |row|
    @csv_contents << row.chomp.split(', ')
   end
  end

  def each
   self.csv_contents.each do |row|
   i = CsvRow.new(row)
   yield i
   end
  end

  attr_accessor :headers, :csv_contents

  def initialize
   read
  end
 end
end

class CsvRow
 def initialize(row)
  @contents = row
 end

 def method_missing name, *args
  num = name.to_s
  if num == 'one'
   @contents[0]
  elsif num == 'two'
   @contents[1]
  end
 end
end
 
class RubyCsv
 include ActsAsCsv
 acts_as_csv
end

m = RubyCsv.new
puts "Start...n"
m.each do |row|
 puts row.one
end

puts "end...n"
