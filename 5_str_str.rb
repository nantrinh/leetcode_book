# https://leetcode.com/problems/implement-strstr/

require 'set'

# I think this is O(n) runtime, O(1) space
# first pass through haystack: store all indexes of occurrences of
# the first character of needle in a set
# e.g., if haystack is "haystack" and needle is any string beginning
# with "a", the resulting set would have {1, 5} 
# 
# second pass through haystack: start at index = length of needle - 1
# e.g., if haystack is "ays" then start looking at index 2
# in this pass, we look for a match with the last character of needle
# if we find a match, then we check to see if (j - (needle.size - 1))
# is in the set we generated earlier. this is checking to see if 
# the first and last characters match. if yes, then we check each
# character in haystack[(j - (needle.size - 1))..j] to see if it
# matches perfectly with needle. if yes, return true.
# else increment j and keep looking for a match with the last character
# of needle
def str_str(haystack, needle)
  return 0 if needle.size.zero?
  return -1 if needle.size > haystack.size

  first = Set.new 
  i = 0
  while i < haystack.size
    first.add(i) if haystack[i] == needle[0]
    i += 1
  end

  j = needle.size - 1 
  while j < haystack.size
    if haystack[j] == needle[-1] && first.include?(j - (needle.size - 1))
      i = j - (needle.size - 1)
      return i if equals(haystack[i..j], needle)
    end
    j += 1
  end
  -1
end

def equals(str1, str2)
  i = 0
  while i < str1.size
    return false unless str1[i] == str2[i]
    i += 1
  end
  true
end

# https://www.youtube.com/watch?v=qQ8vS2btsxI
# rabin-karp (i did not implement this)
# rolling hash
# if you have a good hash function you will not get many spurious hits,
# and your runtime can be O(n - m + 1)
# worst case is O(mn)

test_cases = [
 ['hello', 'll', 2],
 ['hello', 'hello', 0],
 ['aaaa', 'bba', -1],
 ['aaaa', 'a', 0],
 ['blabla', 'ab', 2],
 ['z', 'z', 0],
 ['cz', 'z', 1],
 ['', 'z', -1],
 ['abc', '', 0],
 ['', '', 0],
 ['mississippi', 'issip', 4],
]

test_cases.each do |test|
  output = str_str(test[0], test[1])
  if output == test[2]
    puts "passed"
  else
    puts "failed; output: #{output}; solution: #{test[2]}"
  end
end
