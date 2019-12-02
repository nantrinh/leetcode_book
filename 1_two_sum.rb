require 'pry'
# first attempt
# O(n**2), constant space
# def two_sum(nums, target)
#   (0...nums.size).each do |i|
#     to_find = target - nums[i]
#     ((i + 1)...nums.size).each do |j|
#       return [i, j] if nums[j] == to_find
#     end
#   end
# end

# second attempt
# O(n) runtime, O(n) space
def two_sum(nums, target)
  index_of_complement = {}
  (0...nums.size).each do |i|
    if index_of_complement.key?(nums[i]) 
      return [index_of_complement[nums[i]], i] 
    else
      index_of_complement[target - nums[i]] = i
    end
  end
end

p two_sum([2, 7, 11, 15], 9) == [0, 1]
p two_sum([1, 5, 9, 3], 10)  == [0, 2]
p two_sum([-1, 3, -2, 6], 4) == [2, 3]
