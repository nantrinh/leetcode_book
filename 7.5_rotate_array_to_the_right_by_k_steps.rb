# https://leetcode.com/problems/rotate-array/

# when k > array.size, treat it as k = k - array.size
# reverse entire array
# reverse first k elements
# reverse the rest of the array

# O(n**2) runtime, O(1) space
def rotate(array, k)
  return if k == array.size
  k -= array.size if k > array.size

  reverse(array, 0, array.size - 1)
  reverse(array, 0, k - 1) 
  reverse(array, k, array.size - 1)
end

def reverse(array, i, j)
  return if array.size == 1
  while i < j
    temp = array[i]
    array[i] = array[j]
    array[j] = temp
    i += 1
    j -= 1
  end
end


test_cases = [
  [[1,2,3,4,5,6,7], 1, [7,1,2,3,4,5,6]],
  [[1,2,3,4,5,6,7], 2, [6,7,1,2,3,4,5]],
  [[1,2,3,4,5,6,7], 3, [5,6,7,1,2,3,4]],
  [[-1, -100, 3, 99], 1, [99,-1,-100,3]],
  [[-1, -100, 3, 99], 2, [3,99,-1,-100]],
  [[1, 2], 3, [2, 1]], 
]

test_cases.each do |test|
  input, k, expected_transformation = test
  rotate(input, k)
  if input == expected_transformation
    puts 'passed'
  else
    p "failed; transformed: #{input}; expected: #{expected_transformation}"
  end
end
