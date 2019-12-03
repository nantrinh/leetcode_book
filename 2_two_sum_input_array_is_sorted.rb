require 'pry'
# https://leetcode.com/problems/two-sum-ii-input-array-is-sorted/

# require 'set'
# # using binary search
# # O(nlogn) runtime, O(1) space
# def two_sum(numbers, target)
#   seen = Set.new
#   (0...numbers.size).each do |i|
#     next if seen.include?(numbers[i])
#     seen.add(numbers[i])
#     index_of_complement = binary_search(
#       numbers, target - numbers[i], i+1, numbers.size - 1)
#     return [i + 1, index_of_complement + 1] unless index_of_complement.nil?
#   end
#   nil
# end
# 
# def binary_search(array, target, i, j)
#   mid = (i + j) / 2
#   return mid if array[mid] == target
#   return if i >= j 
#   array[mid] > target ? j -= 1 : i += 1
#   binary_search(array, target, i, j)
# end

# using two pointers
# O(n) runtime, O(1) space
def two_sum(numbers, target)
  i = 0
  j = numbers.size - 1
  while i < j
    sum = numbers[i] + numbers[j]
    return [i + 1, j + 1] if sum == target
    sum < target ? i += 1 : j -= 1
  end
end


p two_sum([2, 7, 11, 15], 9) # [1, 2]
p two_sum([2, 7, 11, 15], 22) # [2, 4]
p two_sum([3, 5, 11, 15], 26) # [3, 4]
