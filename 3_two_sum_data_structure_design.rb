# https://leetcode.com/problems/two-sum-iii-data-structure-design/

require 'set'

class TwoSum
  def initialize()
    @numbers = []
  end

  def add(number)
    # O(1) runtime
    numbers.push(number) 
  end

  def find(value)
    # O(n) runtime, O(n) space
    complements = Set.new 
    numbers.each do |x|
      return true if complements.include?(value - x)
      complements.add(x)
    end
    false
  end

  private 

  attr_accessor :numbers
end

# if you know you will be adding few numbers but calling find many times, then
# you can calculate all pair sums every time a number is added and do a lookup
# when find is called. this is O(1) runtime for add, O(1) runtime for find, and
# O(n**2) space

# if you know you will be adding many numbers and calling find relatively fewer
# times, and you don't want to use much space, the solution above works well.

ts = TwoSum.new
ts.add(1)
ts.add(3)
ts.add(5)
p ts.find(4) # true
p ts.find(7) # false

ts = TwoSum.new 
ts.add(3)
ts.add(2)
ts.add(1)
p ts.find(3) # true
p ts.find(6) # false 
